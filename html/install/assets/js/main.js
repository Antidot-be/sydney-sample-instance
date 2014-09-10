$(function(){

    $('.install').click(function(){
       var installer = new Installer();
       installer.launch();
    });
});

function Installer(){

    this.availableLangs = [];
    this.currentInstanceId = 0;
}

Installer.prototype = {

    launch : function(){
        $('.progress').addClass('show');
        this.progressBarChange(10);
        this.addDbStructure();
    },

    addDbStructure: function(){
        this.hideLaunchInstallButton();
        this.execute(1, 30, this.addDbData());
    },

    addDbData: function(){
        return [this.execute, [2, 60, this.executeLang()]];
    },

    displayUserForm: function(){
        var that = this;
        $('.instance-form').removeClass('show');
        $('.user-form')
            .addClass('show')
            .children('form')
            .on('submit', function(e){
                that.handleUserForm($(this).serialize());

                e.preventDefault();
                return false;
            });
    },

    handleUserForm: function(data){
        var that = this;
        $.ajax({
            url: 'db/sql.php',
            data: data + "&part=5&instanceId="+that.currentInstanceId,
            type: 'POST',
            dataType: "json"
        })
            .done(function(data){
                that.cleanLog('alert', true);
                that.logInfo(data.message);
                var domain = $('#domain').val();
                console.log(domain);
                $('.admin-website').attr('href', domain + '/admin');
                $('.website').attr('href', domain);
                $('.page-header').addClass('show');
                that.progressBarChange(100);
                $('.user-form').removeClass('show');
            })
            .fail(function(jqXHR){
                that.failDb(jqXHR.responseJSON);
            });
    },

    handleInstanceForm: function(data){
        var that = this;
        $.ajax({
            url: 'db/sql.php',
            data: data + "&part=4",
            type: 'POST',
            dataType: "json"
        })
        .done(function(data){
            that.currentInstanceId = data.instanceId;
            that.logInfo(data.message);
            that.cleanLog('alert-danger', true);
            that.progressBarChange(80);
            that.displayUserForm();
        })
        .fail(function(jqXHR){
            that.failDb(jqXHR.responseJSON);
        });
    },

    displayInstanceForm: function(){
        var select = $("select[name='language']"),
            that = this;
        for(var i = 0, length = this.availableLangs.length; i < length; i++){
            select.append('<option value="' + this.availableLangs[i].id + '">' + this.availableLangs[i].label + '</option>')
        }
        $('.instance-form').addClass('show');
        this.hideLaunchInstallButton();
        $('.instance-form form').on('submit', function(e){
            that.handleInstanceForm($(this).serialize());
            e.preventDefault();
            return false;
        });
    },

    executeLang: function(){
        return [this.loadLangs, []];
    },

    execute: function(part, percent, callback){
        var that = this;
        $.ajax({
            url: 'db/sql.php',
            data: {part : part},
            type: 'POST',
            dataType: "json"
        })
        .done(function(data){
            that.logInfo(data.message);
            that.progressBarChange(percent);
            that.cleanLog('alert-danger', true);
            if(callback && typeof callback[0] === 'function'){
                callback[0].apply(that, callback[1]);
            }
        })
        .fail(function(jqXHR){
            that.failDb(jqXHR.responseJSON);
        });
    },

    loadLangs: function(){
        var that = this;
        $.ajax({
            url: 'db/sql.php',
            data: {part : 3},
            type: 'POST',
            dataType: "json"
        })
        .done(function(data){
            that.availableLangs = data.langs;
            that.displayInstanceForm();
            that.cleanLog('alert-danger', true);
        })
        .fail(function(jqXHR){
            that.failDb(jqXHR.responseJSON);
        });
    },

    failDb: function(error){
        this.logError(error.message);
        $('.install').addClass('btn-danger').attr('disabled', true).unbind('click');
    },

    hideLaunchInstallButton: function(){
        $('button.install').addClass('hide');
    },

    /* Logs */
    logError: function(error){
        this.cleanLog();
        $('.alerts-container').prepend($('<div class="alert alert-danger" role="alert"/>').html(error));
    },

    logInfo: function(info){
        this.cleanLog();
        $('.alerts-container').prepend($('<div class="alert alert-success" role="alert"/>').html(info));
    },

    cleanLog: function(cleanType, cleanAll){
        var type = cleanType || 'alert',
            clean = cleanAll || false;
        if($('.alerts-container').children('.' + type).length > 4){
            $('.alerts-container').children('.' + type).last().remove();
        }
        if(clean){
            $('.alerts-container').children('.' + type).remove();
        }
    },

    /* Handle the progress bar */
    progressBarChange: function(percent){
        $('.progress-bar-install').width(percent + '%').attr('aria-valuenow', percent).html(percent + '%');
    }
};