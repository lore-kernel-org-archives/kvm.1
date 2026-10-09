Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4B736B907
	for <kvm@vger.kernel.org>; Fri,  9 Oct 2026 20:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791579487; cv=none; b=QLGa+s9gP2J1AcClKXSnGo5a3D6jm3FS1YxXqHmK5uMpLYUv0skBPqKdxrmtj+jL1a2H6Kxop5BH9g9LgtpdfK6UDDDcadWJicsanxZvd/vHUYFmzIXZ0/pyn4KAyWIwARrhwDNiMLxHvSwUNL7JfQuFx2KS0v5FyQesPrSwit4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791579487; c=relaxed/simple;
	bh=V+RY7E/8ADFShFuMjLzmRHdN9yccpKO1Gep1q5N/n94=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pnaBUPkSM6zcqGl8B6P9PJtEVrkG0d4q0Xtox9PwNGtuoFaZ6Dk8sQqYE0MHmD+RO2bOe8L1IqCu5j0cp5ppv1P/WingS55uUFoLxNjEmyeO78bbxd7u0SstIO33jH/GMk7sAi8i0vkHYH43gTGu8fZoOr1wMTwQxOYKvsY1QT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZPtY7fLz; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZPtY7fLz"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc11b5dd54dso248930a12.3
        for <kvm@vger.kernel.org>; Fri, 09 Oct 2026 13:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791579486; x=1792184286; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LMjGbLW9lc1R7yfLy7ZOR+jBeeIII4unV9kdR2KwDOE=;
        b=ZPtY7fLzHm25PkXlNqdvO18EIPRxsFzPESBkTDGB7UJ7Z9o2i8SVh6i/QD2o6lOxYz
         QTNarvJBHTgx+gfyqfxoCS9Bxde8/lptggpwgJGRRUIIjHZkJfox2rwiaa4JZhODzqju
         LV+Qw9IC2V8Y/VCcWLkPz6ULg3HIonaDM00f1qX1i0ESWF7pyOs8A7ns3yceGeMTQhcj
         t9B0c02fmxK6nfJbzHKYQSz5+2Vl/KI3HlKGY20Z0bezCzxwq6sKnmQMlLpZNCsnD4zy
         pvWKs23+RBKt3bYpUcw1q8JQfWTIb7/pFFHFwTvevswG3qMij35Zl/TUaHU0LrfKp3Oz
         RMEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791579486; x=1792184286;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LMjGbLW9lc1R7yfLy7ZOR+jBeeIII4unV9kdR2KwDOE=;
        b=KXx8eGUFXa4pEX5DjEgs4Yn4NfxGHOAu/oAq901C91XBoilSZa2oDyTtJOhC+7edaf
         CQ+CU0v28R/FbzYhu8x4OSQ+h1GQ8qsC0zW7EFeRDxGTIPvtsixbZY7xvTynlc2eb9Rz
         4QfKlBNgN5b+LXus8jD4lD0cRSiwkKcEqgkN8N5td9o6qe6H1G2IDBpAIQF9xi9UWoL5
         Gm6/fSDEzMsQdW7w/a3+ABr8UhIex699laN9KMj2O+IAbBvrfyB1gCRZSrOOWHx1zdbu
         qM7ya6EJWAaoXkx6rwGsL2yhX1h48XTEk9xHGhbS2P3h4HJrZJUjwFs/BWi4oOdQcs/9
         YRTg==
X-Forwarded-Encrypted: i=1; AKwUvByQin3udWT623E8cWPzyN9mUjm1wNKz8usGsOLSkWlrVfbSRike36OVUj39MVzobqI4q9Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYIFUP4ahHRd3zaYkVy7dZnTaiZK/zKGstqRSnti9MIbm1t4MxeX
	hzpgnYq5/JYuzSetMz9YbN1QGED0jELSWDdITxEO+XZFFO3+bydeDMEZ84yt6UF1lGmv04guJ1M
	xHqNGqg==
X-Received: from pjbch18.prod.google.com ([2002:a17:90a:f412:b0:3ab:147a:52a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e7ce:b0:3ab:9cb:b5a4
 with SMTP id 98e67ed59e1d1-3ab3ac7eecemr2968909a91.40.1791579485511; Fri, 09
 Oct 2026 13:58:05 -0700 (PDT)
Date: Fri, 9 Oct 2026 13:58:04 -0700
In-Reply-To: <asdOF41hqDpycXKU@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260930001127.3170009-1-seanjc@google.com> <3c0ee89f560b0235f293b32019327186785aa795.camel@intel.com>
 <arxd78Pn6WWL6TGq@google.com> <asdOF41hqDpycXKU@yzhao56-desk.sh.intel.com>
Message-ID: <aslVXBSovWuAsNtN@google.com>
Subject: Re: [PATCH v2 0/3] KVM: TDX: Syntehsize SHUTDOWN on unhandled EPT Violation
From: Sean Christopherson <seanjc@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Rick P Edgecombe <rick.p.edgecombe@intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"kas@kernel.org" <kas@kernel.org>, "jthoughton@google.com" <jthoughton@google.com>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"sashiko-bot@kernel.org" <sashiko-bot@kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, 
	"ackerleytng@google.com" <ackerleytng@google.com>, Vishal Annapurve <vannapurve@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 08, 2026, Yan Zhao wrote:
> On Tue, Sep 29, 2026 at 05:55:11PM -0700, Sean Christopherson wrote:
> > On Wed, Sep 30, 2026, Rick P Edgecombe wrote:
> > > On Tue, 2026-09-29 at 17:11 -0700, Sean Christopherson wrote:
> > > > Signal SHUTDOWN instead of -EIO if the guest accesses an unaccepted=
 page and
> > > > has disabled EPT Violation #VEs on such accesses.=C2=A0 Returning -=
EIO is all but
> > > > guaranteed to mislead the VMM into thinking KVM (or the VMM) messed=
 up, and
> > > > will likely result in the VM being terminated instead of rebooted.
> Hmm, it's by design in my previous implementation to terminate a VM when =
the
> guest accesses an unaccepted page and has disabled EPT Violation #VEs on =
such
> accesses, according to the TDX module spec:
>=20
> "This happens if the TD is configured to TD-exit (instead of a #VE) on an=
 EPT
>  violation due to accessing a PENDING page. It normally indicates an erro=
r
>  condition; the host VMM may decide to tear the TD down."
>=20
> So, for the initial implementation, we chose to invoke kvm_vm_dead() and =
print
> out the exact reason as a hint to the system admin.

kvm_vm_dead() should only be used when KVM *needs* to prevent userspace fro=
m
running the VM.

> (Previously, reboot was also not supported for a TDX guest).

But QEMU isn't KVM.  While QEMU is the de facto reference VMM, it's importa=
nt to
keep in mind that it's not the only VMM (and that's not just about Google's=
 VMM,
there are plenty of other non-QEMU VMMs that are used in production environ=
ments).

> Returning -EIO was based on the following considerations:
> - vcpu_enter_guest() returns -EIO when kvm_test_request(KVM_REQ_VM_DEAD, =
vcpu)
>   is true.
> - A request to handle a specific EPT violation is rejected by the firmwar=
e (the
>   TDX module).
>=20
> > > I'm pretty sure Yan had a test for this path, and I'd love to see it =
actually
> > > exercised. What is the urgency on getting this fix upstream? Can we w=
ait a week?
> I triggered the EPT violation in the kexec path, and successfully had the=
 TD
> - killed with error msg: "qemu-system-x86_64: cpus are not resettable,
>   terminating" on an old QEMU, or
> - rebooted on a new QEMU with the msg printed:
>   "qemu-system-x86_64: info: virtual machine state has been rebuilt with =
new
>    guest file handle".
>=20
> The TDX selftests we are using do not handle KVM_EXIT_SHUTDOWN, so if suc=
h
> an error occurs, it's silently ignored by the TDX selftests even with msg
> "kvm_intel: Guest access before accepting 0x8000c000 on vCPU 1" printed i=
n dmesg.

If TDX selftests don't fail due to an unexpected KVM_EXIT_SHUTDOWN, then th=
at needs
to be fixed irrespective of this change.

> > Absolutely.  It can probably wait a month and no one would care.  IIRC,=
 this got
> > hit by someone (internal to Google) deliberately crashing a guest kerne=
l and doing
> > funky things with kexec.  It showed up on my radar purely because our a=
utomated
> > madness alerted on the resulting assertion (on -EIO) in the VMM.
> Though I didn't realize that returning -EIO would mislead the VMM into th=
inking
> KVM (or the VMM) messed up, such an error could also be introduced by a V=
MM bug?

Yes, but that holds true for literally every guest failure.  It's like sayi=
ng that
all observed errors could be due to a CPU bug, e.g. because the CPU corrupt=
ed state
or because a bit flipped in DRAM.  It's technically true, but in practice t=
he vast
majority of failures (outside of pre-production hardware) are software erro=
rs, and
so absent evidence that a hardware/VMM/KVM bug is at play, KVM shouldn't as=
sume
anything.  I.e. as above, unless KVM needs to protect itself, KVM should aw=
ays try
to provide semantics that are rooted in the CPU architecture.

E.g. an analogous failure would for non-TDX guests would be if the host zer=
oed a
page that happened to be necessary to handle exceptions in the guest, and a=
s a
result the guest hit a triple fault shutdown.  KVM doesn't return -EIO inst=
ead of
KVM_EXIT_SHUTDOWN just because the failure could have been introduced by a =
kernel
or VMM bug.

> e.g., VMM removes an accepted page without any notification to the TD con=
figured
> with TDX_TD_ATTRIBUTES_SEPT_VE_DISABLE bit.
