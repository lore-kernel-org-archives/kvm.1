Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7486638E129
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 15:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782401023; cv=none; b=TZuBfAMT3HTZ9Zd/I3cR6H634RB1tuNuSEKSEgywhcmaYn/WKx8Nz9iuL9btD+I++TLrcxGbWbIFzEYr72XKnnzBh5jsBq7qmlKRtTzffitDQH2EmRiFb96DKF/F6qjxQKGnJnuO5Y6v26jXj1KeOwoPOv2drZHTsUXLyx3CCrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782401023; c=relaxed/simple;
	bh=68wQ/N57413y5fmpjsLjrjzh99rTtNfsAvpDaKmHlMo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Htsl4WNbjhPy3DPhptqOjZNzyXs5GP4G1qu0tr0XRjtvBZ2SbMSKknHF5IqgV6PUHrFV+HwgXQwJmEq85nziwZbYkopB/jIBx0ekNuHpAG3Nvs7kAYVSkQgR3sVPCnQkzMOvU49Y9ZP1vhUHLskBECo2YyWHRm5Q4Jsqz8g0u+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FCoMgod8; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FCoMgod8"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8454912a507so3749457b3a.2
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 08:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782401022; x=1783005822; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=B4W/9MmETYpefFGvxRMmkYZZV+m52dEAcM8p8mpMdiU=;
        b=FCoMgod8Ll+kdHa5Dr5EMXa229odtnhdaKh5ZjEF/dxEYAnfBFqFVYfu1O3NEEcmsN
         UcexiJThyzJGLsbLx8AseGpxLy8Jqmn4CyoLI1Nkj772Wm5eJO0qVueWuaqZN6e11N+n
         vt9V9BuKO+Eyi71OyUn7cWjUvBF9uGdYqrGNiSDtg06y5gI/bVkK1L6SMyQxlHpQQJ+e
         WjWtm7r6rA2Ps5jRfwB7o6Yk3PdEKjJKR0T3no19aTTtqw0UDDhAb1+0cvaXtUuWCYyR
         oflw1HCGhmg/WRpgYZxpbZUprOZSeDoM1v3yuoSh5azOQJYtNneT8n5gunzAnrTXtBYw
         Fv0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782401022; x=1783005822;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B4W/9MmETYpefFGvxRMmkYZZV+m52dEAcM8p8mpMdiU=;
        b=MpU+2MjJtpaaYRyZ1oM908/B29UbugaDXlzfYxq82NI5u/bKbn7/zIug8sn+5z8Qys
         q1HMwDu9p15sGyxxxrNuafmWgfadBjfYDrg4BiFp+lXElMAsWsV2ofO3b2vUBiNy8mdH
         FygIF8qsRP7OgRbJNHw7NdccPQ+jSF+Mav+ixs14eBC325qVdse3LpoNFt8laSXQ0hqx
         8RPy5byOELYfZkriQqEZP/OfKpOaSzAm8fiGvSo9fEmI14Y6K+MuH/G+yiM5DB44UUvz
         u/uqvpbbgElfyRYKxFDRGpOBJw+hQQQ7qjI6iPRIX+ZgjE6EXZG0ond+3ooASDjN4tB+
         b7eg==
X-Forwarded-Encrypted: i=1; AHgh+RpQZB3unzcfqXaPUp/h1PI0wOawySqXYydLHEbrJekc7k13+fS7NdqicI/iPtJwPd22u0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzLVbFU1oyKJxN7vissjhycm6VZZJtNXCabrtnd027jYHdfLtq
	QONwP3lJ085nfMb3RJY8ThkKqmLwq1Xo5qWVs+n0sVMQoTErlZ8xMxnB6W1LiUGQADmaTIlQ8BH
	BIpgUMw==
X-Received: from pfqy5.prod.google.com ([2002:aa7:9e05:0:b0:845:bd02:c4cb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2d81:b0:842:7476:2373
 with SMTP id d2e1a72fcca58-845b3bc5d15mr3671613b3a.44.1782401021410; Thu, 25
 Jun 2026 08:23:41 -0700 (PDT)
Date: Thu, 25 Jun 2026 08:23:40 -0700
In-Reply-To: <6a360fdf.871e809a.2d6dda.0000.GAE@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <6a360fdf.871e809a.2d6dda.0000.GAE@google.com>
Message-ID: <aj1H_JvSc5rxLSs4@google.com>
Subject: Re: [syzbot] [kvm-x86?] WARNING in vcpu_run (2)
From: Sean Christopherson <seanjc@google.com>
To: syzbot <syzbot+dd769db18693736eee89@syzkaller.appspotmail.com>
Cc: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, 
	pbonzini@redhat.com, syzkaller-bugs@googlegroups.com, tglx@kernel.org, 
	x86@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Jun 19, 2026, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    8c13415c8a43 Merge tag 'media/v7.2-1' of git://git.kernel...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12ec001c580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d4e6991ab3edc95e
> dashboard link: https://syzkaller.appspot.com/bug?extid=dd769db18693736eee89
> compiler:       Debian clang version 22.1.6 (++20260514074242+fc4aad7b5db3-1~exp1~20260514074407.73), Debian LLD 22.1.6
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=157ce8ea580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1176e566580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/27752fb81380/disk-8c13415c.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/192b476e0df1/vmlinux-8c13415c.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/ba635e3d5aec/bzImage-8c13415c.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+dd769db18693736eee89@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> irq == -1
> WARNING: arch/x86/kvm/x86.c:10860 at kvm_check_and_inject_events arch/x86/kvm/x86.c:10860 [inline], CPU#0: syz.4.1716/11103
> WARNING: arch/x86/kvm/x86.c:10860 at vcpu_enter_guest arch/x86/kvm/x86.c:11356 [inline], CPU#0: syz.4.1716/11103
> WARNING: arch/x86/kvm/x86.c:10860 at vcpu_run+0x57ec/0x7950 arch/x86/kvm/x86.c:11770, CPU#0: syz.4.1716/11103

#syz test

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d9d51803b7b2..14a62c2ce3ad 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10797,10 +10797,12 @@ static int kvm_check_and_inject_events(struct kvm_vcpu *vcpu,
                if (r) {
                        int irq = kvm_cpu_get_interrupt(vcpu);
 
-                       if (!WARN_ON_ONCE(irq == -1)) {
+                       if (likely(irq != -1)) {
                                kvm_queue_interrupt(vcpu, irq, false);
                                kvm_x86_call(inject_irq)(vcpu, false);
                                WARN_ON(kvm_x86_call(interrupt_allowed)(vcpu, true) < 0);
+                       } else {
+                               WARN_ON_ONCE(!pic_in_kernel(vcpu->kvm));
                        }
                }
                if (kvm_cpu_has_injectable_intr(vcpu))
