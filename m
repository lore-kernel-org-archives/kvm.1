Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222F5488DBA
	for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 21:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787694861; cv=none; b=KRkUn4UidRYaY/7Xm44gUzfyHlDYpfoo1tKL+erPU/z6qUn+F3Ks8kumcttRUTGG6z9lGYz/eQVKM2TMg7cRvnEs0fWT1uVSq2TWB9aww7QWZtPxvVDc3dSeWtm86+kRFqtMuRQE7EUGqvIk2ljvCMMAV2M9ig6KxD6G/IFa5uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787694861; c=relaxed/simple;
	bh=XR8NWL48ttmRpATl2VS8DikQa6bsodivQLy6Un32ANs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cHlrmv6G5Zw6Ye+SpKZkm5entYc0GJxrdrkJQe2IMLvtxnAEkpCyILtiSr2ljgSFgVcYC43F9QvLDWATmCc7i2QF21Al0RxfHB1OO10InjXCu6shucC8DJaOo/YaiQsHupAWBXunoLnjfAq+S7tIPUR8k+79uiQnhMAwTFLsWkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ksxce6pK; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ksxce6pK"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d6ae2a942dso6008845ad.3
        for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 14:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787694853; x=1788299653; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OTWHpOVqzsgigOpGCtEHl9Fp7RfetEno19tkznsmu8o=;
        b=ksxce6pK4QHpSPAixNU0QmH+KpUNSPmeK46mJ4R2zQ9V0WCERcyyR7Q/RLBBLVnNG8
         L9+c6jZX+bsduhBDE8QMmFaj1JM9LvhEJ+d5lYHS2ml79RCeifhhHDFetLVP2VWr7pJf
         1DdQzPDZDqtclvCBnU7lhG79ReWaRBIavXhmJw2qGHK5f5tObZTCj+IcVA5rjQSS+RFv
         0aJUW+BnzdMt2VtVsVV1YnvoBP9olvVsxZHMaTwo2T0/5YFFK/kcNaLhv9NFtOrwtYgt
         zttwwx81pS74jq3cJ0sKg4W/MmzT+dT72J5I2CHL8HDWwE6jMu84b0deUiava8pflyaG
         C+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787694853; x=1788299653;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OTWHpOVqzsgigOpGCtEHl9Fp7RfetEno19tkznsmu8o=;
        b=tSqw6/YHA5/2oqky3qBNbDJvwOjKQ9idOOKgSTtht1bEOuW5McSaPAuYMoZhZ+OuEP
         5DsPcjHCMvQpbmFoCm4XLAMDTXf7migRU0Zb7KsjM53JDBnc0MAJ2QRKuL8JOjlQLnwL
         Pcr2rkqQjnnvYkLqOQSMc0jAA+kSEgxd8ezWh3/KWjGDUOOCyMkHC2r8UW1gi44f0by5
         LSSjpKgwmOufyUQHrtkF8qcx2cM+9giqmifalU7UqUa1BLsrNJ3ZIr6qu9VRH/JH3WI7
         HIBEr4D49aAziXr2ERiRCTvD+DGzfnZrdYYsi4w/OXz4pI2RW+pbJ3ZSKIRJZXKxNwV0
         Sw7w==
X-Forwarded-Encrypted: i=1; AHgh+RrURinPClL9KaCfoL+P40KfOE/5gONbPXR+SgQFisAtfo8bmStB37EQInY5AkcWl8W+kY4=@vger.kernel.org
X-Gm-Message-State: AFuF++m903CbIlmImD/RDwDvp9hfVxFNj0YIo6OFsMl6eD0NB+XLlAy+
	KiTAnlFGvFqEXzydiA5A2Rwz9dZfalc6/q+jyfdULqIR2NqZ+ybNSeiMXBE+vzX/x+3mrMfG/Rh
	n6Etn/g==
X-Received: from plsq20.prod.google.com ([2002:a17:902:bd94:b0:2cc:e88e:4245])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ebcb:b0:2d6:3c2f:6a5
 with SMTP id d9443c01a7336-2d707b9cc29mr25705135ad.14.1787694853363; Tue, 25
 Aug 2026 14:54:13 -0700 (PDT)
Date: Tue, 25 Aug 2026 14:54:12 -0700
In-Reply-To: <20260823135031.4F6DC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260823-shivank-gmem-fix-split-v1-0-512a29fb8e86@amd.com>
 <20260823-shivank-gmem-fix-split-v1-1-512a29fb8e86@amd.com> <20260823135031.4F6DC1F000E9@smtp.kernel.org>
Message-ID: <ao4PBDFO9wAzMFxQ@google.com>
Subject: Re: [PATCH 1/5] KVM: guest_memfd: take the invalidate lock when
 unbinding a dying file
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: Shivank Garg <shivankg@amd.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Sun, Aug 23, 2026, sashiko-bot@kernel.org wrote:
> [Severity: High]
> This isn't a bug introduced by this patch, but does ignoring the return value
> of xa_store_range() here and in kvm_gmem_bind() lead to a use-after-free?
> 
> Looking at kvm_gmem_bind() in virt/kvm/guest_memfd.c, xa_store_range() is
> called with GFP_KERNEL:
> 
> virt/kvm/guest_memfd.c:kvm_gmem_bind() {
> 	...
> 	xa_store_range(&f->bindings, start, end - 1, slot, GFP_KERNEL);
> 	filemap_invalidate_unlock(inode->i_mapping);
> 
> 	/*
> 	 * Drop the reference to the file, even on success.  The file pins KVM,
> 	 * not the other way 'round.  Active bindings are invalidated if the
> 	 * file is closed before memslots are destroyed.
> 	 */
> 	r = 0;
> 	...
> }
> 
> If memory allocation fails during this operation, xa_store_range() returns an
> error pointer, but the return value is ignored. This masks ENOMEM errors and
> leads to an inconsistent state where the slot points to the file but the file
> doesn't track the slot.
> 
> Because the slot is missing from the file's XArray, when the file is later
> closed, kvm_gmem_release() iterates over f->bindings but fails to find this
> slot, leaving slot->gmem.file as a dangling pointer.
> 
> When the VM destroys the memslot, kvm_gmem_unbind() accesses this dangling
> pointer and calls get_file_active() on it. Can this cause a use-after-free on
> the freed struct file, or improperly increment the refcount of an unrelated,
> reused memory object?

Thanks Sashiko, for spilling the beans.  I've been sitting on a patch for about
a week (this got reported/found by multiple sources internally), I'll get it posted
today.
