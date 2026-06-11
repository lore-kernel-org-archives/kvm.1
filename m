Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030BD3BD64E
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 10:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781173574; cv=none; b=bWsuu+HdaKi6RimI3bgbrgpljsBNt/XgRIjxD7GmRLQha3UgYVkI0RE37CGbaBEytrcUQN8d0oy8m/pf/NtAmXjSTLvh8mRtPVqL0U5wVTRCr2sqt33KTu/XDNZ9EJIFOpCiAYHupRbOoICrHUZ0XQ+Wn6hP/AYV0Ln1FpYubTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781173574; c=relaxed/simple;
	bh=OYF6ddkk3ET0wAeRY/wQV7hV65LJccEaJSb2nV5o52Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SdI3DcG5Bd0MGYXJcNVyLeGfyEPQ9KAMyDkPaPqZK+j+c7+s6hjxhLOI91yzzWfJnJXcSVZMm/ct3cLtqEXqZyCpcgX9iHK+PaTiRRErvUvOAW8BBbkYFNC3tY4tq/HE8jjPGxY8tiiz7Q97xROtTmZ1FtzPVM6cl9FsBA7hDnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PcktueAW; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PcktueAW"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2bf30d530bdso77322725ad.3
        for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 03:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781173571; x=1781778371; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x/E0m/5TkIBZvgQ0HlAzPa+9c4QWmFVzmLz408thX2o=;
        b=PcktueAW4vmfe7k8T/R4YOZKTKdnMSfVucKutzpF4+a8S/LHkTHhFG85NngSIHdUUP
         8QFBeeO07Nyo2BI7ed6aIvYJdBXR/BBVcX+IWDM9reIQlajahs5E2bs9SJ7PoDye0ehc
         8Ad3JPOfuBsAijeUT+LjZAB/5nF/ojyaOac2EGkrMzU7vtEy/oufMZHMimSvXRofefnb
         GXs+ix1V3sc0rN/LtPuwlXQx2y3wLzwKv/BCxBrScvZ2+X+M/rCpBcus8IpOgu1ACO0d
         63bmZm1Z2BA6iQNbO78D5kqk2kfueAD4hcetjFRdrd+KM26LvK+sybGELsRezoE+JOPv
         I9zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781173571; x=1781778371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x/E0m/5TkIBZvgQ0HlAzPa+9c4QWmFVzmLz408thX2o=;
        b=Nuk7r3NSgdFVZziOxz4STQDXvIOk4tsQMQG2KOnaxSNd2nTn6ENf2bzaPl0EEQ2pCy
         7vFyxLoKOSB/ksPkXcrovO7R/VJD0xuOtrRwm7ZJccUok7d8jKIGSZQzk11sjNNEc7T5
         vOyhAfrJ8yJ081t0MoFsIhAxmxjBLm+eiFqf5BAByepxeiNV9BeqsMTLl0o1w881P3xY
         p523qF5fMfdZ73z2iOgSr4dPSxO4eaVGzEVDEerPIsEIxyBR8unZOxnObRfc2hnGAtIM
         ZV+OZTboVkkUe3NcJZl+lwp3qFAMnah3ulnad2gb3zIYwn2HrZBuccXhVh6VyF2QUbVq
         s/Bg==
X-Forwarded-Encrypted: i=1; AFNElJ9rd/s3+WKFC3N9+X0cy2j/wDejNJrf4crYZngFo/f4gXCoL0+AnQOoNHQkVKDCDJRlZbc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yytay5pOQiisixlwscWb3Pdm3pe9VuK22OAC+3HFmBhLLRYMJiS
	qQT+Lc3SXYBGzImTn0FqdklSkPT8e8xo1FiqL20OzzvGYCCp+u8wHqNZ
X-Gm-Gg: Acq92OFFDdoJcyyK/2yXKNOJ9Uur4ZmWpga39QXBBwIZGXZqYPyCW+g4BHVjHdNAlnX
	IRZhiB/fvTbkugCKf2FeWTIsXKvIpjdBTYr1iNMnovt625Zqo1C9CVa0SeA5GPa5/KXihchW4aP
	056HViNSbqi+Fc9DL34dbbXE7CdyrX6kl4O7pYTLnTXwiOBBjYOO7dOKa0M1kfoIwGLvsXNt8N0
	VbuiqD0JBGaPMzuHpZIctJV4AWxrFa/78PtPSyzvdTnsIaHQYN3U6AeljxhNUxFaOlqXd3Mc9R8
	8Xy4aZJAiARK5C99TpgAhA0YemB2itMMZKQ6ajbQH/Rz360jWZllRstngAnchjmfLcQLNwWvPS9
	n0ibU4hyyIfEh/jeRxVr3a8xU2SdeK980TFDBLbRv1QjyLd41wj8NTjr/Dy78thVZ3OSv9w9dw2
	Eix7Xm+4EiUaDpncHYP+IeltH811h6yqzVwlDKOFspes42cr32IyVh/A==
X-Received: by 2002:a17:902:ea0e:b0:2c1:f262:4962 with SMTP id d9443c01a7336-2c2f4215d8emr24953295ad.20.1781173568964;
        Thu, 11 Jun 2026 03:26:08 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d59csm260349715ad.4.2026.06.11.03.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 03:26:08 -0700 (PDT)
Date: Thu, 11 Jun 2026 19:26:04 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Michael Roth <michael.roth@amd.com>
Cc: seanjc@google.com, pbonzini@redhat.com, tglx@kernel.org,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, kvm@vger.kernel.org,
	imv4bel@gmail.com
Subject: Re: [PATCH] KVM: SEV: Don't return a still-assigned gmem page to the
 host
Message-ID: <aiqNPBQzoU9f8RwI@v4bel>
References: <aimMWzAf5b3luM0b@v4bel>
 <wxamg6zqn2qmsci2fwfepbqou5vtgydqmonr67mu7b73nkakbe@zedss5vzeci3>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wxamg6zqn2qmsci2fwfepbqou5vtgydqmonr67mu7b73nkakbe@zedss5vzeci3>

On Wed, Jun 10, 2026 at 05:16:57PM -0500, Michael Roth wrote:
> On Thu, Jun 11, 2026 at 01:10:03AM +0900, Hyunwoo Kim wrote:
> > [You don't often get email from imv4bel@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > 
> > sev_gmem_invalidate() is called when guest_memfd frees a gmem page.
> > For each PFN that is still assigned to the guest in the RMP table, it
> > transitions the page back to hypervisor-owned via rmp_make_shared()
> > before the page is returned to the host.
> > 
> > A guest-assigned page can reach this path while still private,
> > because the free path does not transition it beforehand and
> > sev_gmem_invalidate() is the only place that does. A gmem page used
> > as a vCPU's VMSA after SEV-SNP AP creation is one such case. When
> > rmp_make_shared() fails, the RMP entry remains guest-owned and the
> > host cannot use the page because of RMP protection, so it must not be
> > returned to the host. The existing code only issues WARN_ONCE() and
> > continues to the next PFN, returning the page to the host allocator.
> > 
> > Leak the page instead of freeing it, as kvm_rmp_make_shared(),
> > snp_page_reclaim() and sev_free_vcpu() already do when a transition
> > back to shared fails. snp_leak_pages() does not take a reference of
> > its own, and on this path the page is freed right after the hook
> > returns, so take a reference with folio_get() first to keep the page
> > from being freed.
> > 
> > Fixes: 8eb01900b018 ("KVM: SEV: Implement gmem hook for invalidating private pages")
> > Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> > ---
> >  arch/x86/kvm/svm/sev.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> > index 6c6a6d663e29..8fee6ec529f9 100644
> > --- a/arch/x86/kvm/svm/sev.c
> > +++ b/arch/x86/kvm/svm/sev.c
> > @@ -5178,8 +5178,12 @@ void sev_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end)
> > 
> >                 rc = rmp_make_shared(pfn, use_2m_update ? PG_LEVEL_2M : PG_LEVEL_4K);
> >                 if (WARN_ONCE(rc, "SEV: Failed to update RMP entry for PFN 0x%llx error %d\n",
> > -                             pfn, rc))
> > +                             pfn, rc)) {
> > +                       /* Still assigned to the guest; pin and leak rather than freeing. */
> > +                       folio_get(page_folio(pfn_to_page(pfn)));
> > +                       snp_leak_pages(pfn, use_2m_update ? PTRS_PER_PMD : 1);
> >                         goto next_pfn;
> > +               }
> 
> This roughly aligns with what would happen if snp_page_reclaim() fails
> in sev_gmem_post_populate(), while the guest is being initialized via
> KVM_SEV_SNP_LAUNCH_UPDATE ioctl, which calls into kvm_gmem_populate().
> 
> However, in kvm_gmem_populate(), we still free the page. Maybe, to
> address both cases, we should just add a parameter to snp_leak_pages()
> to tell it to take an extra ref and use that in both of these paths.
> 
> Or we can just do the direct folio_get() in both cases, the above
> formalizes the handling convention a little better though IMO.

If I understand correctly, an extra ref alone still seems to leave the
LRU corruption that sashiko flagged:

https://lore.kernel.org/all/20260610162623.061BA1F00898@smtp.kernel.org/

A gmem folio is on the unevictable LRU, and taking a ref keeps the folio
on the LRU. page->buddy_list, which snp_leak_pages() uses, shares the
same union as folio->lru, so leaking the page overwrites the folio's LRU
pointers. Both paths deal with a gmem folio, so the same applies.

To handle this properly, the folio would need to be taken off the LRU
before leaking, with something like folio_isolate_lru(), but that is
mm-internal and does not look usable from KVM. How should we proceed?
Please let me know if I am missing something.


Best regards,
Hyunwoo Kim
