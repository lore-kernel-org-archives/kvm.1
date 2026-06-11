Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8736C4ADDB9
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 17:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781199284; cv=none; b=ZD0WhuMIO/9TGdmIS5rbjOvATSPIrNYHw9Z49EBICc0h6TXXz5c03CCgY6Vg+fw6zzJVZf+fo1F8qBR02Djx5zKtZSJxHbowsalNy9W50tB0bbnFSRUuBygx4Y5T0opv2SttPg8mT0Eh86M6ZZlvRP5smyz8dgLe3I+fpqRrwpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781199284; c=relaxed/simple;
	bh=OIv9ouq09MgI5krTsUm/5SfNecTv4VMgcOmixRfSGM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jvhZTgT7wlfIBOuSK4XrMADfVNxOvVDlajvZ4lXCvuC17m14FE2p4gwo+yAsrvWaSkHJ2NuHqIq5AXHQP/6y3T/m3b+MAvOsFBxVw7wMcb8npCfcgl8l0+zmW8dIUIqo9ECpHH3AKDbSUgUQu2pClQ0Tkxa3s+hsLC4ft0MlxRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CVeHpd+F; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVeHpd+F"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-36b903567fdso245976a91.1
        for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 10:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781199283; x=1781804083; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EY599Sp/ykzAojtyBgCQdqIuFOHCkQUvHRQjXrhYD+0=;
        b=CVeHpd+F+LyaB+Z9orX3H/nTP93Q8Ervhb00unIjJQ+9ndrEo35S3nKqJjC1Z7l3fk
         dV2EyqWCxsndXkge0WnApXpFkblDBVZQJ4BJf14EPNvw/RVV2bUCDb7qdCkc1NbJcl+1
         pS8hml7g1OdBNkp6SS1ki25ndvSeXnXoLMKYjwPfPuUyinbywMIRSUAQpBgNMfC4NCpv
         i5gNjmII0YUSM8vT4V272Xr69M20TrDK8zLNXrWbMD3dqBp3um4njVfgV3hqj3HUsG7d
         hRaS0rnB+i3DFIReCgcs8RKyfRNSmDTtRsIvBrkxR0F9693hcir2Vi1A50C8fwa274vm
         iZlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781199283; x=1781804083;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EY599Sp/ykzAojtyBgCQdqIuFOHCkQUvHRQjXrhYD+0=;
        b=Nj5TKIkEDXJUol6+7IrDMmjqw41TsESOkvz0r7RX3dVNQ/7F4PE7Pfrq5wz/bi7uh7
         SjdfOa/wfReWGSAzN9bCTVAzLuKvBubJ2HucaRUKB5R2L4eJKvEFQT5kGnsxe8ttFywi
         n6m0wkZPhG896qIpSFCwfJmNNqPAzJ6gXEmpQhqAgaNU6mwQMdQG/jaNzKw7+yyn4E0I
         9bGZpN6CWkLaE9dbrXyUWY+nz+CDyI4tpqxDl+50+ZnifCnpgMVccnEBKNwTgOtP1TZQ
         gMcENHP2o/+BkwnaR1JwhBLkz95RMcvwGyeldBtT/ZsxJn0EW7rEReHWxmlKQnYfCciU
         xnsA==
X-Forwarded-Encrypted: i=1; AFNElJ+A33ysVNyTejxXMhmaB7bbLTVLsl/RsgiWh/kJB3mvcWxomoTpPIh9ZAIh5+d1Jf4uV+w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzymgdcq8sxfqV6c9BS0CDnYBv9t+Qc5fNyHB0UEJVL663Y4fMs
	u8nZH7kJ0qbscleddXFd0Wq/U7ZCgqq6FWn4HNxpB5gj+grShRueOe/L
X-Gm-Gg: Acq92OELn+bIPL/H31nUEoEJvWkeAvshGQ3edYf3dvL5wIYrgAErPB6EGM23E2sPKoR
	eweDFss0ZPAMpEO/UgsnDwOyelmBfj6VHacrCS86H5+FN7FwvguFQd+K54DSkuE3b1hK0hktjkZ
	Qx1HScZGFkF1xZGF+fv1ZbKeiHijtcHCttXF4m5AFxn1f6N3qXs9z5GZ24k45DfvQUnBOdFHAF3
	i3sVY+O22WJP0hWl3DV+1E62O+2NUnb0E5XGZFF+Nl968SJnTu2X299GwYoMax5Kesem6kxKxPK
	32CsI4l8hNQhNJBI8yYBXAE6h1eyZ94kB64b1DhvTLf5boDzVC4DF5ZiLfMEI6xXrYRp8C+m59o
	drNThg1l70kft3WkyAzMG6ea7o5GnugzBEX4eu0qpUWuRmStFB/XSE+wRc69J575SYVwwac+4sq
	5Kn7vVQ3l7ZbZ97FRkJGBpX83VKfEZHNNA6k/d6g2SgD8=
X-Received: by 2002:a17:90b:4c0f:b0:36b:9c4a:e05d with SMTP id 98e67ed59e1d1-377a8dbbd07mr4486827a91.17.1781199282891;
        Thu, 11 Jun 2026 10:34:42 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3775549af93sm3572346a91.10.2026.06.11.10.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 10:34:42 -0700 (PDT)
Date: Fri, 12 Jun 2026 02:34:38 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Michael Roth <michael.roth@amd.com>, pbonzini@redhat.com,
	tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	kvm@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH] KVM: SEV: Don't return a still-assigned gmem page to the
 host
Message-ID: <airxrhqF6YbatIcK@v4bel>
References: <aimMWzAf5b3luM0b@v4bel>
 <wxamg6zqn2qmsci2fwfepbqou5vtgydqmonr67mu7b73nkakbe@zedss5vzeci3>
 <aiqNPBQzoU9f8RwI@v4bel>
 <aiqueNUndQsbMNud@google.com>
 <airAthcKDZeDfzXS@v4bel>
 <airS1G23atiuWdTl@google.com>
 <airrbMQafcuxoVkg@v4bel>
 <airxMoy44ZxkbioH@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <airxMoy44ZxkbioH@google.com>

On Thu, Jun 11, 2026 at 10:32:34AM -0700, Sean Christopherson wrote:
> On Fri, Jun 12, 2026, Hyunwoo Kim wrote:
> > On Thu, Jun 11, 2026 at 08:23:00AM -0700, Sean Christopherson wrote:
> > > On Thu, Jun 11, 2026, Hyunwoo Kim wrote:
> > > > > > To handle this properly, the folio would need to be taken off the LRU
> > > > > > before leaking, with something like folio_isolate_lru(), but that is
> > > > > > mm-internal and does not look usable from KVM. How should we proceed?
> > > > > > Please let me know if I am missing something.
> > > > > 
> > > > > I'm inclined to do nothing.  rmp_make_shared() should only fail in this case if
> > > > > there's a fatal bug somewhere, no?  Either that or do BUG_ON(), because at some
> > > > > point these types of errors are simply unrecoverable.
> > > > 
> > > > A guest can make a gmem page a VMSA via AP creation,
> > > 
> > > Ugh, the bane of my existence.  Can we kill off that feature yet?  I'm only half
> > > joking.  Not even half.
> > > 
> > > > and if that gfn is then hole-punched, a page that is still assigned to the
> > > > guest is returned to the host in sev_gmem_invalidate(), which looked like it
> > > > could lead to a host RMP PF, so I sent the patch.
> > > 
> > > Yeah, I suspect you're right.  But leaking the page doesn't fix the underlying
> > > problem, which is that it's possible to free a page that's being used as a VMSA.
> > > 
> > > We can't simply pin the page, because IIUC ->free_folio() is called when the page
> > > is removed from the filemap, not when the folio/page is free back to the allocator.
> 
> ...
> 
> > > The right way to handle this is to treat the VMSA "mapping" like an MMU mapping.
> > > I.e. this is fundamentally the same mess we have to solve in order to not pin
> > > pages that are mapped into L2 via vmcs01/vmcb02 for nVMX/nSVM.
> > > 
> > > Something like this, sans the actually handling of the request.  The simple way
> > > to handle the request would be to invalidate control.vmsa_pa if snp_has_guest_vmsa
> > > is true, and then redo the mapping part of sev_snp_init_protected_guest_state().
> > 
> > Understood. This looks like a fairly large change, at least for me,
> 
> Heh, definitely not just for you, it'll be a large, painful change for anyone :-)
> 
> > so would you be able to handle the patch?
> 
> Yeah, I'll work with Mike and others to get a fix landed.  Thanks much for the
> bug report!

OK. Thank you for the review :)
