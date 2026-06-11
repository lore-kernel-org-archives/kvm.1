Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E332DA76C
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 14:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781186749; cv=none; b=SkeD4l3tnhANemC/j2IN0JOUTqoDlmQvr6116EWPoTBLsZCVydUnE/kuhOU0rjQsgXhV4nki1nfL1rbyjmtjdhJIDfvJ4PhM2qNCuPRAcW02q1eatOlr4NbZ5zqNptq0GMFQJOXMytRNaDLiYRay9tKzw5oVJ5j80w6c7fV3FvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781186749; c=relaxed/simple;
	bh=AqimZuxnqUfrezsEH+Sz6qflq6i0vJ5V/j/HpPqDpNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W9plw0g60D45UpQzY2Os2DDNDmtsM1EVbSDuCKsS/ba4M0UP+g3QKLCQhpnPDdR6OUfutL+4rsGfJI8O9JeLlcqrTMCn2hqkfDEAwLdTEJVDS1IINRLqaJLBoj4sZFjROGwLRsqB0RHyX1CJLUct88m/i08ibOuVkCJM7FBBxz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sJDxNJlm; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sJDxNJlm"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8423b08b293so3528618b3a.3
        for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 07:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781186747; x=1781791547; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TP6Pfmt/pNFjeeIcm2Z/10SyLFOCvj+gpzvr/UkoQEY=;
        b=sJDxNJlmhaCIly5UWVJzOk9WID1brZKHjV7K0rYSdSb1gzYggfTgf0b3V76vcynZPI
         UEQF88TnfSsDdtIfizrdQ/GbyIm59sjeyfsIahiIvIFdIRxIK/XRcjLJNib98rsPIzj6
         auUA9o7L/cUWjPmsw2ONL3Lc3KEvtFQOOCmMpAlguGv997gNVVUb0/oAv2NWNtzfEegY
         x2iPxvc1WRnAwXfCqz/GURt9akdHHmaxYTPrkFe7miZ/1XmUbpvqlKLfXX3bU+3K2Av/
         JitCnDp9/kNxSdSxEQiuqPylwKob6V6bStg8xACqCjj+SGg9jsRM+aTU6Gic5yxKVQCU
         rOSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781186747; x=1781791547;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TP6Pfmt/pNFjeeIcm2Z/10SyLFOCvj+gpzvr/UkoQEY=;
        b=BYBts4BBamHJvnHwc7De5rp1IUzJYsQUvQdiHxSqCDRhrP9BdsFglLFoSicZxlm8HQ
         7u6KXbNtEDemWnqV7LCd3JjIRflQH1Vf34MtXJccYE4r+gBejxa1Mbf+l7if33O9anhU
         m/QKxPcwZ8b2YoD8hgbh17eHU//JAGn0Qeo/XUV1rbAjfEiLC1cnfNiuDqW4X9aBKbui
         hXE8LDZILzi1fO6eT1QB4yOy7IZeRgPkOEFUg1RTPfJKV+dA2s1gV1Li4C880RO2dgUE
         7idLZfA6DhuyDs0/hxGDKeRhI08mgZfWUfI+dQuVDJtGoEU2qh38sJXGbpJD2FodnhXw
         OOTA==
X-Forwarded-Encrypted: i=1; AFNElJ/onEn0hJiYZlJ+wb6ZePQOR40jWJFP/POWC5CH9ERVYv1LZ7SH7a+e4KsG+TRpLQVcbns=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5XMUnUZ/566BrTMBysr3EgV2QNPL0C5BnP+FPDPmvjUXCtohJ
	a+i/xrhNWE+hhaSdALMGwBxkCxEpQsZ8l65BAT5S5P+a9XvvoLiGiTb6
X-Gm-Gg: Acq92OEKsiSQ+exQrEeyI2I7PvTX9P7S/6mP7H23TNquVjHUFy8+KV8nOEhgFn+KQ8R
	bBMj8QtpOML0vf8i0wnK3EjF25zp8J7uK7KVS65c5k3H8errmP2LLGZZUpm4k0hKqTsrBxr0Ipz
	FAYwpbjxAV/a8dWmbm33Wk5sr4S/HAREwTR7esT1kpfBBzcRqPivt4aQnkzhiUzj1oOhYFSTthW
	Iul54J7u9zW1HdKUrgxGPPYEaP1vv/40fgiawr5L6hV1teMoJROHgVIVQSuNFaLdz9+QG+pzYfC
	SheVYsTBcJoM3IRspD2eoqywQE4+4+1izaGKOnaEImKS9CkG8go7DUM7JvIyklQ0jCC4pK4APS7
	3byLDsHczSuugBEMuTC0CreEMxmdU1NAr93Kl0OgY/qKoAVSd28tO5OBEjWyG1wz8EdVbpJVXWP
	Umk6EMLQAwGMijLVhnNQJZW7WtSGvNZsrDgC/2fJJAtmCKYiUmAn8gv7/A3Z+Q7FRj
X-Received: by 2002:a05:6a00:e8d:b0:842:74e3:48a5 with SMTP id d2e1a72fcca58-843367cf117mr3165653b3a.16.1781186747033;
        Thu, 11 Jun 2026 07:05:47 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84337bb6ca7sm2339178b3a.14.2026.06.11.07.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 07:05:46 -0700 (PDT)
Date: Thu, 11 Jun 2026 23:05:42 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Michael Roth <michael.roth@amd.com>, pbonzini@redhat.com,
	tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	kvm@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH] KVM: SEV: Don't return a still-assigned gmem page to the
 host
Message-ID: <airAthcKDZeDfzXS@v4bel>
References: <aimMWzAf5b3luM0b@v4bel>
 <wxamg6zqn2qmsci2fwfepbqou5vtgydqmonr67mu7b73nkakbe@zedss5vzeci3>
 <aiqNPBQzoU9f8RwI@v4bel>
 <aiqueNUndQsbMNud@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiqueNUndQsbMNud@google.com>

On Thu, Jun 11, 2026 at 05:47:52AM -0700, Sean Christopherson wrote:
> On Thu, Jun 11, 2026, Hyunwoo Kim wrote:
> > On Wed, Jun 10, 2026 at 05:16:57PM -0500, Michael Roth wrote:
> > > On Thu, Jun 11, 2026 at 01:10:03AM +0900, Hyunwoo Kim wrote:
> > > > ---
> > > >  arch/x86/kvm/svm/sev.c | 6 +++++-
> > > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> > > > index 6c6a6d663e29..8fee6ec529f9 100644
> > > > --- a/arch/x86/kvm/svm/sev.c
> > > > +++ b/arch/x86/kvm/svm/sev.c
> > > > @@ -5178,8 +5178,12 @@ void sev_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end)
> > > > 
> > > >                 rc = rmp_make_shared(pfn, use_2m_update ? PG_LEVEL_2M : PG_LEVEL_4K);
> > > >                 if (WARN_ONCE(rc, "SEV: Failed to update RMP entry for PFN 0x%llx error %d\n",
> > > > -                             pfn, rc))
> > > > +                             pfn, rc)) {
> > > > +                       /* Still assigned to the guest; pin and leak rather than freeing. */
> > > > +                       folio_get(page_folio(pfn_to_page(pfn)));
> > > > +                       snp_leak_pages(pfn, use_2m_update ? PTRS_PER_PMD : 1);
> > > >                         goto next_pfn;
> > > > +               }
> > > 
> > > This roughly aligns with what would happen if snp_page_reclaim() fails
> > > in sev_gmem_post_populate(), while the guest is being initialized via
> > > KVM_SEV_SNP_LAUNCH_UPDATE ioctl, which calls into kvm_gmem_populate().
> > > 
> > > However, in kvm_gmem_populate(), we still free the page. Maybe, to
> > > address both cases, we should just add a parameter to snp_leak_pages()
> > > to tell it to take an extra ref and use that in both of these paths.
> > > 
> > > Or we can just do the direct folio_get() in both cases, the above
> > > formalizes the handling convention a little better though IMO.
> > 
> > If I understand correctly, an extra ref alone still seems to leave the
> > LRU corruption that sashiko flagged:
> > 
> > https://lore.kernel.org/all/20260610162623.061BA1F00898@smtp.kernel.org/
> > 
> > A gmem folio is on the unevictable LRU, and taking a ref keeps the folio
> > on the LRU. page->buddy_list, which snp_leak_pages() uses, shares the
> > same union as folio->lru, so leaking the page overwrites the folio's LRU
> > pointers. Both paths deal with a gmem folio, so the same applies.
> > 
> > To handle this properly, the folio would need to be taken off the LRU
> > before leaking, with something like folio_isolate_lru(), but that is
> > mm-internal and does not look usable from KVM. How should we proceed?
> > Please let me know if I am missing something.
> 
> I'm inclined to do nothing.  rmp_make_shared() should only fail in this case if
> there's a fatal bug somewhere, no?  Either that or do BUG_ON(), because at some
> point these types of errors are simply unrecoverable.

A guest can make a gmem page a VMSA via AP creation, and if that gfn is
then hole-punched, a page that is still assigned to the guest is
returned to the host in sev_gmem_invalidate(), which looked like it could
lead to a host RMP PF, so I sent the patch. Other sites such as
snp_page_reclaim() leak the page on this failure rather than freeing it.

If you think this isn't a real problem, leaving it as is seems fine to me.
I don't see a good place to put a BUG_ON.
