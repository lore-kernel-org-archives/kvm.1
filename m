Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3464F384250
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 00:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782175324; cv=none; b=BJU37B52y7CnM0O7L/3yyXzPTDh6aZd4y5qSA905A5Yo2hHF04HCVG2YHwcT5ptQlm2XQ/Jox0MnTqWHmmQfd1KGz8Gw6psrDtmwODms4RHhtCSPQ3qGszcFsFlB3y4ECEsiVvVZSbfXIi7yXzXlF7bHcOf6VqeGY+VeHjFtMxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782175324; c=relaxed/simple;
	bh=KwUqj7nhoHDhIuRDD1Xp7nbnthWPTVmrcZsXCZ16fVI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LQ6egxiDGAEdIV/SZALNN0gfE2qV+epJldTBDZ7Wxvh2dF6YIfiJVzFNx4BcbhiHq+a3udqQ7BOWHrvkcaV2tSOEo2Ck1TJmEQ6AfH1scwK6KuNdGGrgA+R+qlE1wL1VTpeH6cTbpQWr9ok/8OtD64xJNFYVIJ2i9FglWWfGuJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-486e64c8edeso6993070b6e.2
        for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 17:42:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782175321; x=1782780121;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QbsGXYDBBVR67WbkMrc1s5CRse+QBADx4nI89RRSsII=;
        b=Mweb5tv41b3zlfQ8lBwAkIDMJkxxbQl/Wj5Y8JAOQrErYYO1bGG2LCjQ1kBcwims5l
         LFd09vTxs538JwyzKLJWWUriHaG+g5Hy/bt7jH6iIJfAC2B6izjUaPooGynv4eP5ypuy
         X94eF69MS6j2TjOVhaREDZlZmylMpxcdOGJHZMgcRHrog3GbPZab2fRW5BJsAJZNRTQd
         8oi63HC492rBHZgeUS1LWIAXQZpX5MDiFleYspuqGLim81dBjuxfxswAvx9BPH/ezy30
         Ey7sWQu8KwIggo5IdH5X+i9/J5bSLciTpwzxd1nT5MQugGiIgkxAQm5oaXHtdKiBgz+n
         gUvQ==
X-Forwarded-Encrypted: i=1; AFNElJ9un+cF0bFlh7/3djeOyKHXqCLC9O/saQcxW6Y6F1NSISRufXYiY0S6+NDl6DcxjnIAWjw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9Gx5qTpztZkKdcM/nQ42u9TMgxNdz6f/gbP7cqpX5U1cdrZGB
	jB7OV3Q05FyMBHg8o37TDoSmZb9X/lffoUxCMkGnaZo2I6BN8qjpQ6TxyLNePnKL5JhCUV2CmNb
	l+RT173Y8BvzeDumLEangybDGd3EIWf6ALvGSFeiIwS7M3jzfjrv5k373+BI=
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:191e:b0:489:f088:5f70 with SMTP id
 5614622812f47-48f27b2be16mr619900b6e.12.1782175321280; Mon, 22 Jun 2026
 17:42:01 -0700 (PDT)
Date: Mon, 22 Jun 2026 17:42:01 -0700
In-Reply-To: <ajnPfP1Y2sSIEY3F@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a39d659.c358b6d0.89040.0001.GAE@google.com>
Subject: Re: [syzbot] [kvm-x86?] WARNING in hv_tlb_flush_enqueue
From: syzbot <syzbot+5d2b94b77112148d1744@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, 
	pbonzini@redhat.com, seanjc@google.com, syzkaller-bugs@googlegroups.com, 
	tglx@kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+5d2b94b77112148d1744@syzkaller.appspotmail.com
Tested-by: syzbot+5d2b94b77112148d1744@syzkaller.appspotmail.com

Tested on:

commit:         aec262d2 KVM: x86/hyperv: Ensure vCPU's Hyper-V object..
git tree:       https://github.com/sean-jc/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=167b177a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79a99f123f20da7b
dashboard link: https://syzkaller.appspot.com/bug?extid=5d2b94b77112148d1744
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
