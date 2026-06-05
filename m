Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A363D16E0
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 15:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780672087; cv=none; b=ZF0DNMQRavbYbYtkTX/yT/Jztk0Lvv58QI8/72lsxddVzJevwcIln/NzlA1HUYpDAaVPnlhRGbLOBPTxHDdJN1IzM0o7z+aInZLH/U0keiN1NyJcDsWVgHLDxjWMFe4+DDOu+DdhRncheozc0ygET8ZaVIPPqVb+oKlvMokf3QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780672087; c=relaxed/simple;
	bh=GnWslZKxkJE9xB08+ekHTQdefld2rfPqsDtvLC5Ga5k=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qAxLkJAuK5U9lBI5uW/dzjvbT5u8RYo8PXwyyVvFJGtOArZqhzD6F2JErlxOkgo63zI5wrgtLukgphKWe8OGSgPJnzfzT+6TldYpbjaT79mnuYZZKdS0aKvSLUx6mGnHfZ23BSFDTE6z88znCLrjT/WT2mlo4cZfYRZ2ONr1Fp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7e6f905ea78so3890218a34.1
        for <kvm@vger.kernel.org>; Fri, 05 Jun 2026 08:08:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780672085; x=1781276885;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U/DshfBIfXp3lbos4TyRSUlnbuAOZYkO3ZQ+FvrT0kA=;
        b=Ra6ZImWwylo1BT2prfOZHvL65d5M2Tuf6LUIbQQvgZSDZhibR9z8z8Oejh4yWw/zEC
         BL6LQyo8V2fe4CCCWTOJfeMXKG7DlIczt/i5nYEnsZi+50getAWbNsF+KB3bj3v1KpcS
         VttSapWTh6wLN6iyIZvoy/Pk7ZeqlAOmkmOnzj7Fksq/fB6Z2WyZOJVdyLotzWHv34KJ
         o6TSDC9pAqfCbrMBwKJPaUzl4ddzz3NsTmh3Q16fMumh6LJzzrO0isyXiXRzLEdUO1Vs
         +TBZVRmfDmMw0ujmnoJ7/o0NLBnJuYPkfyX8vcmV9pj917Z1d4cOPYcWZNeh52qb7AYt
         OdkQ==
X-Forwarded-Encrypted: i=1; AFNElJ/zIz4a+VMtZQnkwPAhwQvBJ3G3W2Nl+Ji14I6OpgrN8vVqxoeJ+ej2GvJq2CRUJgvGwe8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaTRoK3dFXyiju9YfXGurWIWSVtsUs6gpQwvCgApAFxy9Bb2XQ
	qoeMCfzF9Zp8sMzgmZDvwIjty6uTMqbQFQ9qth8m+Cy1wgG8sYfeWEJk0n4VGtTl4t5TJB5mz6J
	y5VDpx3RjwklGnyYCMbwRugMiUHR1qyVhKvYpbfgk32m7XGm0Ybp/r4w30RE=
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:82a:b0:69e:43a2:353 with SMTP id
 006d021491bc7-69e68b15781mr2156143eaf.2.1780672085113; Fri, 05 Jun 2026
 08:08:05 -0700 (PDT)
Date: Fri, 05 Jun 2026 08:08:05 -0700
In-Reply-To: <87951e9a-a43c-4538-9ea8-ee1ed37d786e@suse.de>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a22e655.39669fcc.2372e3.0001.GAE@google.com>
Subject: Re: [syzbot] [kvm?] [kvm-x86?] INFO: rcu detected stall in
 kvm_vcpu_ioctl (4)
From: syzbot <syzbot+3d5461510f8dc4adfe30@syzkaller.appspotmail.com>
To: clopez@suse.de, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
error: corrupt patch at line 56



Tested on:

commit:         ddd664bb Merge tag 'net-7.1-rc7' of git://git.kernel.o..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=f7a09bf3b9133d9d
dashboard link: https://syzkaller.appspot.com/bug?extid=3d5461510f8dc4adfe30
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17ab8f2e580000

