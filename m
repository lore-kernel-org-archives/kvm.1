Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793018007;
	b=4a5CBmEdGxA+ZIVNYBvCs1OY+0G2ZJq0b7vVUNAmobwT3nHLGrTx7YPqHnQy0M5TLHBv
	 JkUMdXhMRHZ9KQXeu4Upxw9QCcqqknMhWYPtAXu5t2Bf6/cyewUZOGBZ1rYaVDJTj/fqo
	 ygW9HQXfxTlhcadpvRJdre5dJWy+DTEEmnIQC1vxF24cP7UbYgt4yuBaO532Zp7vxUEu6
	 IRXK+sIP4o2dzIjh2xS6111+lalIQwJ583jl/HNSf60zHB/ZUvnJfVL56pVMAw5U83V3N
	 /1tlOkNEoVAvburenkXB4/WtpbEet0wQvtPDdvAI1VONiMp/JyDGjpG/jaF/CViLuPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793018007;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 MIME-Version:X-Received:Date:X-Google-Appengine-App-Id:
	 X-Google-Appengine-App-Id-Alias:Message-ID:Subject:From:To:
	 Content-Type;
	bh=u8+pcVYUXZ59pd4XuBmGqxA5UKZbGLrNgoafEzcb9iQ=;
	b=gG9h8xzmYNmUBXNnG3Nf7nomNe3LV9xu3Qd2ckDhjZk5nXV6Amq30/kdGHgQy8w+wPv5
	 UszVNawXpaj7zLS5GYDV7tK3aDgJB5OLuu/MSUK4CrrSPFaistbfTPJYdPSZ7rsj76M3I
	 sJNhgrcbSzWyzV/sbb14anmOzbqWwurn3TVEGrgPK7WpeWfkSM8MP0cVcUsqrXZYrImum
	 aCpNSivfZRPDbxXUaXbKzogip6TFmnOoQ2Nolr5Nv37dYzyXHUayvqrRFLv4ebvYa1fCo
	 PTeXCmYISYBp/ycEV9huqHlJCs8eR1s7yAT3i0arqu++u7MwKm3rm4ZpyxaU7RBXujQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.160.69
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2CE606A31F
	for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 12:33:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F2CE606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-4a72bcd6599so2946528fac.0
        for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 05:33:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793018006; x=1793622806;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u8+pcVYUXZ59pd4XuBmGqxA5UKZbGLrNgoafEzcb9iQ=;
        b=vZgTIn/ssYKv1EVenEoUa8QyFhYXVdmBc6m83EATAeea9tjsXHutZODXzGK4sGQKZ3
         mpIqBVp3zep760eiW2K7ustyLIi9NU3kid5hxscgb2s2OB5c6ExZpzUPrvu585amq2c8
         UtJSbGQq5aUc3VXK+bIslguBKsWA7knPanDhqizlSZO2apMiinR9ym3Xg+O/CpyUBL3C
         MK676jAUl5OTWduvYLuTBzTGzdlwpzBCnjlRHH/9BlxwZfEqeWXUSjhX2MPyRSNWmCXU
         og6JOxU8Kqi4VNJvelkMANuO/XXL/DkCDFqC0Uj2Bud9UYOO3bh1GO0gs2HMioqyfIvz
         qr7g==
X-Gm-Message-State: AFq9FYK9oTrGIjLgFspKsI2F8oxavc+ZuNkzDcfpGq8lFG1qrK2BXBCf
	Hwe3kCVuYdBW+WyXttxpBOEmNCspS8unldLKQ6NYApqLqoFxj9AcWN5EhkenSHsuNe5l21+y4IN
	6q5m3bVV+PjP10ibaCBZrZ+W+KI+G4xCuOEdKbd0zTcVFIYVAYlMYZ/Rk0Hk=
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:50a1:b0:54f:c850:fa53 with SMTP id
 5614622812f47-55c002622cdmr4280399b6e.17.1793018006476; Mon, 26 Oct 2026
 05:33:26 -0700 (PDT)
Date: Mon, 26 Oct 2026 05:33:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6adf4896.67317f00.38c4bc.00b4.GAE@google.com>
Subject: [syzbot] Monthly kvm report (Oct 2026)
From: syzbot <syzbot+list297a1f23e39576d8b4b8@syzkaller.appspotmail.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello kvm maintainers/developers,

This is a 31-day syzbot report for the kvm subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/kvm

During the period, 1 new issues were detected and 0 were fixed.
In total, 7 issues are still open and 72 have already been fixed.
There are also 2 low-priority issues.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 2256    Yes   WARNING in __kvm_gpc_refresh (3)
                  https://syzkaller.appspot.com/bug?extid=cde12433b6c56f55d9ed
<2> 44      Yes   BUG: sleeping function called from invalid context in kvm_mmu_notifier_invalidate_range_start
                  https://syzkaller.appspot.com/bug?extid=c3178b6b512446632bac
<3> 2       Yes   WARNING: locking bug in __refill_objects_node
                  https://syzkaller.appspot.com/bug?extid=f11512d1e5878ba5e60e

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
