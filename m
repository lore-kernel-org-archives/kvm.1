Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB4054CF56
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 13:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790084830; cv=none; b=H5NCnToS+Dnw+dbCKVeT4Xl3WPPwxwbDJ3N9b0dSLPjzlf7Gc0irElaRZDcvWah1rDUddg4tiHAIRxqSwdeTycVA2dNExTgd0ts9gwEvtOIwr8pAiqHsu6ud3Bc4riBZyh/NgOWp4JOCCZnxrighkPWRslQfxEYolB0gOWCP5r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790084830; c=relaxed/simple;
	bh=5gvU+dfQVMRPWQ21gMFhIRzC1AVqMIy6KUq7tbBNbqk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oUrc3ck0/imVzwerUdzPCqLNBA5sjanwnmX2yF7SmRQk0nefn57Y5oxiOweAB10RKAMniSS76QIM7ILpoTo1cyFqQ8L+pCpj7kRsn3pDVhmf0GLyunVNnUEPDpmE8szdww9a4HuNEr0VuQiTNotk5dQ7oMG2APangngvtJ6yZ4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=obtd6cey; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="obtd6cey"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cbb20f82a0eso3110082a12.0
        for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 06:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790084828; x=1790689628; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gFVUblfJev4NVGqt+kG3dG5mRgj7javR5w3TB/1uDD0=;
        b=obtd6ceyRGwK7No7zsPtVWXCogKk9sj8ZKTY8CJGgfdXV/t0NheLAGxpEIq2gq3+Ep
         FKYc+GWKv3W9C8jx4AB4bRHt0vzI7Qc59WHPNYzTAC3QtgnqQQI90VbSGLdqapL5FidD
         sPgNBVXzfAi5+PLAVjG3vrz/0cH8XIomXowyoPSCrKv819FY42fyl+qZtGdeLaKaS/Bk
         rfVljYNxwPFQGteZo5JWfVy+4aS+MvqvTQa9xQaOJzv7c9n3Z4JBdFremJyrwhvE0edE
         weszMmwe7s2hM4Sx7xxPAIepmoNAhpEGltfQm/fQixNNI+PMFi0KAvfBGddjTjEuOWO0
         gKBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790084828; x=1790689628;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gFVUblfJev4NVGqt+kG3dG5mRgj7javR5w3TB/1uDD0=;
        b=25b2Rp06/LVCrGZhCgGaXcf9HCQD8aAZJxoNjbSZgzijIAcb/y/ozr9bIOOVo8ufPa
         CEnXE16c9itgyTHlpentzTNmq13Ynoh8FXV67gZ6Sj6xzqquNnfI37ugY7GsaJMFpTZb
         0tlq+CyDl89+5AA1ixr5dNsXuYaEc56UeNYf+dXhyoZ3pB+eIt/2PxqQv1vHUZyMSBz4
         +mIl+RcNHE/vy0gZlPK7Uaxer8igsOCqM2U1V0tKUGP/IpKFhslLGKeF5l78Tvrh6vFU
         BnXxKX7Fi9Feo9lS1/9vvggKNcYwjvBCfVlCQ9MWzrmy9/oE91MfcnPGiuLjwPS9I71P
         73/w==
X-Forwarded-Encrypted: i=1; AKwUvByN4MH7la1xKHinnMnIWesAkaDi3TBP3Dnw+fKHsriBGDuQvL0KjLs2t0m8D4n/ah72k8g=@vger.kernel.org
X-Gm-Message-State: AFuF++no6KDXOiGqSNNcjQJiWKlLO4V7R8YnPQMGe4VwHSjFzjzcO2Jr
	S5e5+iYAIp04Yp1tdVTjwMuGvFDGoECIcftBk2MI4+8JdEX7w4GmNV+svbRUPkN02/UmiRV9m9J
	67d3jFw==
X-Received: from pflr16.prod.google.com ([2002:aa7:9890:0:b0:87b:2034:f271])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3e28:b0:86c:a9a8:844f
 with SMTP id d2e1a72fcca58-87c81cc17e7mr1327689b3a.1.1790084827682; Tue, 22
 Sep 2026 06:47:07 -0700 (PDT)
Date: Tue, 22 Sep 2026 06:47:05 -0700
In-Reply-To: <arJsKA8MkSdpQxNm@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260922001332.1121266-1-seanjc@google.com> <20260922001332.1121266-7-seanjc@google.com>
 <arJsKA8MkSdpQxNm@yzhao56-desk.sh.intel.com>
Message-ID: <arKG2UnTWySdOAkc@google.com>
Subject: Re: [PATCH v5 6/6] KVM: guest_memfd: Drop superfluous WRITE_ONCE()
 when binding a memslot
From: Sean Christopherson <seanjc@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Stefan Teodorescu <fane@google.com>, 
	Dennis Tighe <dtighe@google.com>, Sashiko Bot <sashiko-bot@kernel.org>, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Sep 22, 2026, Yan Zhao wrote:
> On Mon, Sep 21, 2026 at 05:13:32PM -0700, Sean Christopherson wrote:
> > Drop the superfluous WRITE_ONCE() when setting a memslot's guest_memfd file
> > during initial binding, as the memslot *must* be inactive and unreachable.
> > The superfluous WRITE_ONCE() was added by commit 67b43038ce14 ("KVM:
> > guest_memfd: Remove RCU-protected attribute from slot->gmem.file") to
> > maintain rough "parity" with the existing rcu_assign_pointer(), not
> > realizing that the only reason rcu_assign_pointer() was used was to make
> > sparse and other checkers happy.
> > 
> > Cc: Yan Zhao <yan.y.zhao@intel.com>
> > Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
> > Reviewed-by: Ackerley Tng <ackerleytng@google.com>
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  virt/kvm/guest_memfd.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> > index 80932f4ec4a3..826d26036926 100644
> > --- a/virt/kvm/guest_memfd.c
> > +++ b/virt/kvm/guest_memfd.c
> > @@ -677,7 +677,7 @@ int kvm_gmem_prepare_memory_region(struct kvm *kvm, struct kvm_memory_slot *slot
> >  	 * kvm_gmem_bind() must occur on a new memslot.  Because the memslot
> >  	 * is not visible yet, kvm_gmem_get_pfn() is guaranteed to see the file.
> >  	 */
> > -	WRITE_ONCE(slot->gmem.file, file);
> > +	slot->gmem.file = file;
> >  	slot->gmem.pgoff = offset >> PAGE_SHIFT;
> >  	if (kvm_gmem_supports_mmap(inode))
> >  		slot->flags |= KVM_MEMSLOT_GMEM_ONLY;
> > 
> Thanks for the fix.
> Reviewed-by: Yan Zhao <yan.y.zhao@intel.com>
> 
> BTW: some questions regarding read/write to slot->gmem.file:
> 
> The WRITE_ONCE() in kvm_gmem_unbind() and kvm_gmem_release() are also invoked
> when the memslot is inactive and unreachable -- are they also superfluous?

The WRITE_ONCE() in release() is necessary, because the file could be freed/released
while it is still attached to a memslot.

I _think_ the one in unbind() is now superfluous after 0ee2c883b62d ("KVM:
guest_memfd: take the invalidate lock when unbinding a dying file"), but that one
needs more analysis.

> Do we need the READ_ONCE() in __kvm_gmem_get_pfn(), considering that other slot
> fields (e.g., slot->gmem.pgoff) are read without READ_ONCE()?

Yes, it's needed, because of the aforementioned release().  The other slot fields
are only ever modified when the slot is inactive, i.e. unreachable.  That's why
I think the unbind() WRITE_ONCE() is unnecessary; KVM should only unbind when the
slot is inactive.
