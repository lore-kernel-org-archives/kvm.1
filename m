Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795638828;
	b=Ejki0t5+enQC+fY+J6l5T4IsbP1/Xv9TrlDPQyIFrrr3uve8D+nyBg7EkjIak/1rW0tc
	 7xJoUt3VDNHSnxAlWBl39ZvOa75yI/nsk7dXrcVNypEeNLzpX0fFmD7yswarMSfb3qC8a
	 GAjvcSzFKg6QV9tN518+bV0VpJ7lUYCXM8alASnZXh6IQzd7YXax9+xpAKnVAnz2vXKpi
	 ltquE4LEPEXrjiwg7/vRx5r6l3xtXDB73Vv3mWKUy4xs8BHSjlnUghobk60l35FhZU98i
	 3NV+AaCcKHWYUHAUKxOXkPCiyTPRLn8T+11wzOnjFRmYYDPPnrQPNvbxDZ8d44841Og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795638828;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 MIME-Version:X-Received:Date:X-Google-Appengine-App-Id:
	 X-Google-Appengine-App-Id-Alias:Message-ID:Subject:From:To:
	 Content-Type;
	bh=DKdFZEjspBKaCksbplAgcWaym3kv8iUnI1Z7i05QBJ0=;
	b=jOgE70APTGAxBwga65RvrXKlCNZJSCwxYrfDfQMij801VrTO6jBpfvtI5YxdEu+Gx0sX
	 DZIMy6Vhb8nabNbkYR+N27mNwyw0OtZOcUshpS1xits/rZQ/cqYAt6F4Gws9jA62PCW84
	 mce/GQ4GS47rFNGk2yhLSExe+Zz5TvqSHW2BuoHbRHq5qYtDvhEkc/4SI+3s06S3FHfAb
	 /os7NYs/cwLf9fmLrXPlUHUzeAqoMwO5zWdWkbYJsVAjeNg65TSsEB+w+geGUMHyqjSLd
	 jdhwZHV5EDDfdRpUTHCKPrPiWy9cStbcO+JkH/1FEUfnx2gHK6umYdTHm0Puaw/pbgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.200
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799A4606A32A
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 20:33:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 799A4606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4e778acdbc6so7344637b6e.3
        for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 12:33:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795638827; x=1796243627;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DKdFZEjspBKaCksbplAgcWaym3kv8iUnI1Z7i05QBJ0=;
        b=bfzZlrEB9pYwmaUJeFeC8hEd8a0ZjUzyvPvcTlLHUFBpvxN90appTVuPo5YnPmn4bE
         RBV8VgwEuKfi/QCod90gJSZCireK7cfLlHbnWomSnRTWS5nKwb3r8AZ8NHGjx1FHEdg1
         Asxtutis29AkpbL5KIZsMKlnSci6XK0qFfU6oDl8uZ6F+1ddwDDapNBdjeNNINne3o/L
         f+w28GVBdRn42ltiNaD2YEaje2bsaX4mnNdu7IQcn8UjInV7cqzQituvLeqI3/sIGmaA
         w1y3MMC4ziFQP6OqaErTzIgWFcFLae2sDbsRFD9X1FpJBEry9JHDQQtpJyGpTrsiQfJx
         vxDg==
X-Gm-Message-State: APuU4Z+G670NlO68Tv9nXmAHFvXoGVTii/ucznGwI0lq9zL4yKEMjc2l
	zNwiufibucQVEgBh/pSA3S8UKxFt1DpYznCMLb2PvESyzh/xnM+bN/1wN5LYoG5Xm1//VALrECh
	QN1FdYxVmw5d++yQUiIrf6p1f92YnJU+axMtYjA3OcoWKP4Ogh78zB9JKQN0=
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:4f25:b0:540:5827:6d8c with SMTP id
 5614622812f47-57a0c5b9ac4mr21453481b6e.57.1795638827669; Wed, 25 Nov 2026
 12:33:47 -0800 (PST)
Date: Wed, 25 Nov 2026 12:33:47 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6b07462b.bb6e6ada.e0302.000d.GAE@google.com>
Subject: [syzbot] Monthly kvm-x86 report (Nov 2026)
From: syzbot <syzbot+liste72734dcb7f580078332@syzkaller.appspotmail.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com, 
	seanjc@google.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello kvm-x86 maintainers/developers,

This is a 31-day syzbot report for the kvm-x86 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/kvm-x86

During the period, 0 new issues were detected and 0 were fixed.
In total, 3 issues are still open and 83 have already been fixed.
There is also 1 low-priority issue.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1123    Yes   WARNING: locking bug in kvm_xen_set_evtchn_fast
                  https://syzkaller.appspot.com/bug?extid=919877893c9d28162dc2
<2> 376     Yes   WARNING in handle_exception_nmi (2)
                  https://syzkaller.appspot.com/bug?extid=4688c50a9c8e68e7aaa1
<3> 5       Yes   WARNING in x86_emulate_insn (2)
                  https://syzkaller.appspot.com/bug?extid=fa52a184ebce1b30ad49

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
