Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968E837DEB5
	for <kvm@vger.kernel.org>; Mon, 12 Oct 2026 13:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791810960; cv=none; b=usySyE99GNg4K7Z11M+6UD5cjRMksH4Y/3RtSF+2RSj7Nojv+GScUhUHiDFPxzy4ZUThy/v5QG0HWNroFC7HYM+wXvpYaikIP434P4/2fkStIk2rP5LihUAufhQoYPQqug8iGNOS2WFcIGnqGqtlPo/Z/t3kLsA3470hll6R7XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791810960; c=relaxed/simple;
	bh=xPyYERiI4Q6AfUdAOldljcoGfq2AnvPTXQYmen3edCk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=elkbiPsyiF0uABCp0La1b6rMCzggU3jvXjCBOGi5zpM3NMk9xvZaa9Vk0CEl+NoHz6VjS9MlUZhAttGH5NuhU41AFNtdR7RBBsOm4ZA97+W+kzbs4bNIkC6z1qhbCXiLEr3YGYL3ta7a1KpPEM8K4/GsraSSs0qI36hzwyn7SIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QPl0d4b3; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QPl0d4b3"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3a813204f87so1448591a91.3
        for <kvm@vger.kernel.org>; Mon, 12 Oct 2026 06:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791810959; x=1792415759; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gHHQ3heGxmvzhSaG+FW3OED46/i9POKwWnKdCTyUaS8=;
        b=QPl0d4b3yAwLmkUsqungDuKvZDo7WdVOrFLa3K9Hf+wemzYYzV9EL98nJIGB5wi637
         /aTwHvD2DcJNPQSZeKKEGQdWo/StTKTurB1gPa2/TphvSksB0cJrMtVHHg56nZoKh5Zw
         I2tYHMvzdq10l9I27NTgcWcf2XjbQFWqaSXgw+x9fRTj+1OCigV+8DRyavIOgv/1EmSg
         nmSh5Kt7XtP0g554bf1IGHkako4V/YJ4rN4/4aHvpe+cuwG7T44RTdrNsez2bc40tPIa
         sVlzrTIPWBxZCaXQoJsBAxaA2MzGqwil+/Mv8tJJTSYqqS+mKJb5XCs6SWCAfRYpPspo
         u2/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791810959; x=1792415759;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gHHQ3heGxmvzhSaG+FW3OED46/i9POKwWnKdCTyUaS8=;
        b=u5veui93wjO+r8P+ut5tC5rpq4oMgy+JNnh+TFMCwQQ6FmKF0yjyKmVT91OIiNY+X6
         J7qAKluKvCC5ku7vPRdAwovB4AFS82hpHTPPjpO739e3J6bjqJLBm0rlxkV4ReaPuYHP
         qOHObl2TeIe6cTiBvtvL7Ejk5f74pQA71Cv3Dntr/4DcBhO6mu7d79rSE2Gn0bH9hyub
         KTohfoyksq67IHa0z3yPOoTSHDJwteaZqqfv/TTDgBoIDz3HCMIwwTfYGNt8iIjlOHBi
         i4MFKgnnM6fieF6bnNqIiXBSnCTFNQSF1ROTUIM64nXrHNSbrXPhC4CbWnwU2wG0RIWr
         z38w==
X-Forwarded-Encrypted: i=1; AKwUvBxN5gsvMw0miUKY/fI2IMhJ3Ko1YnIfHzPtfuo57RUw55j6X42LVGIn9lJNRmhMTjcSXHQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLpVBXPbRBtHKBSFAM/imke+jmC6GNmrXtioa8DVGCtx7A4j9IT
	pY97iNyyKRd7cso1rjCXtGfErV+X5sZo1X0UTJV8bXyQpmW2VLuDxW36mJaE697C+lgb8JEcBMs
	9DmoUsQ==
X-Received: from pjbbl14.prod.google.com ([2002:a17:90b:98e:b0:3a6:7ee4:e327])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5444:b0:3aa:fc22:8aa7
 with SMTP id 98e67ed59e1d1-3ab3ac72e81mr7467432a91.53.1791810958601; Mon, 12
 Oct 2026 06:15:58 -0700 (PDT)
Date: Mon, 12 Oct 2026 06:15:57 -0700
In-Reply-To: <asmjItCkW74Z6AV1@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260930001127.3170009-1-seanjc@google.com> <3c0ee89f560b0235f293b32019327186785aa795.camel@intel.com>
 <arxd78Pn6WWL6TGq@google.com> <asdOF41hqDpycXKU@yzhao56-desk.sh.intel.com>
 <aslVXBSovWuAsNtN@google.com> <asmjItCkW74Z6AV1@yzhao56-desk.sh.intel.com>
Message-ID: <aszdjZCNWdIiXniC@google.com>
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

On Sat, Oct 10, 2026, Yan Zhao wrote:
> On Fri, Oct 09, 2026 at 01:58:04PM -0700, Sean Christopherson wrote:
> > On Thu, Oct 08, 2026, Yan Zhao wrote:
> > > On Tue, Sep 29, 2026 at 05:55:11PM -0700, Sean Christopherson wrote:
> > > > On Wed, Sep 30, 2026, Rick P Edgecombe wrote:
> > > > > On Tue, 2026-09-29 at 17:11 -0700, Sean Christopherson wrote:
> > > > > > Signal SHUTDOWN instead of -EIO if the guest accesses an unacce=
pted page and
> > > > > > has disabled EPT Violation #VEs on such accesses.=C2=A0 Returni=
ng -EIO is all but
> > > > > > guaranteed to mislead the VMM into thinking KVM (or the VMM) me=
ssed up, and
> > > > > > will likely result in the VM being terminated instead of reboot=
ed.
> > > Hmm, it's by design in my previous implementation to terminate a VM w=
hen the
> > > guest accesses an unaccepted page and has disabled EPT Violation #VEs=
 on such
> > > accesses, according to the TDX module spec:
> > >=20
> > > "This happens if the TD is configured to TD-exit (instead of a #VE) o=
n an EPT
> > >  violation due to accessing a PENDING page. It normally indicates an =
error
> > >  condition; the host VMM may decide to tear the TD down."
> > >=20
> > > So, for the initial implementation, we chose to invoke kvm_vm_dead() =
and print
> > > out the exact reason as a hint to the system admin.
> >=20
> > kvm_vm_dead() should only be used when KVM *needs* to prevent userspace=
 from
> > running the VM.
> Ok. But my previous intention was to kill the VM regardless of whether th=
e
> userspace handles KVM_EXIT_SHUTDOWN or not.
> Did I use it correctly?

No.  Returning -EIO kills not only what KVM sees as the VM, it often kills =
what
the end user, i.e. the customer in our case, see as the VM.

> I'm asking because you added the Fixes tag and "Cc: stable@vger.kernel.or=
g" for
> patches 1/2 as well.
>=20
> > > (Previously, reboot was also not supported for a TDX guest).
> >=20
> > But QEMU isn't KVM.  While QEMU is the de facto reference VMM, it's imp=
ortant to
> > keep in mind that it's not the only VMM (and that's not just about Goog=
le's VMM,
> > there are plenty of other non-QEMU VMMs that are used in production env=
ironments).
> Hmm. That was the reason for me to choose forcefully killing the VM insid=
e KVM,
> since for the initial implementation, I didn't want to bother updating ev=
ery
> VMM :)

Why would any VMM need to be updated?  VMMs already need to handle KVM_EXIT=
_SHUTDOWN
for TDX VMs.
