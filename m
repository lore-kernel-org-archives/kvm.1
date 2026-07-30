Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83933A71A8
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 08:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785400620; cv=pass; b=jmGAZZ/1pONiFJmCfd7+T7WDXi+KI7AuiYudmvxArBCNKeWkDlKTvPf+q73dlS3E4Y2ho32LAqbHcHFyzIGwlermeCo5sPHFxL15IXXVsL9P7HYOO4XMybO5NzRctJZwXrGB97a9BsrgAwhd9c7xUMPBcfqv8UvReyX3BtjqaEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785400620; c=relaxed/simple;
	bh=ldWeQqgVGENPbiJuTTfJy3Ypb6F9mvW5Q7qKkHhULXY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H/ISk2wblq0JmhtPc0aU6j/gFDkonsRwoQAY9BePyByA1uTGlB2dTq0sVIhwHvo+TwkIZmHbCIqgzD5BHu9mtME2zh24RIfIJ80M7eAfYV3dKesZMG5CohMpDN/5dtk5l14i9sGEfqpaZt1JHA8B5K0IeoHxwoYcsCV2mgJhoMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W0NwZ75Z; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VNx0kEQl; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W0NwZ75Z";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VNx0kEQl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785400617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BJTv0GnfJX61s9kcSSNJonT/FIIHCaZ/xJUeqJ7IGYU=;
	b=W0NwZ75Z/NcLz8bYBT+D4/Ymt1m4ewGSV8tNuPhVdV5GyWsqZcXVZj0cHhOmIhWwiE50Rh
	g1dpi97X8TwndaigeCz9MiIJ5/RiA2y/oU/ibkHhWkySbI//yOnA1uO8MpcH8awOuYNntg
	488tV3u1bHhTI39r1Y2SZxUJt3/dfxw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-v9bcfdPmN-WHxp1TI4ZcNw-1; Thu, 30 Jul 2026 04:36:56 -0400
X-MC-Unique: v9bcfdPmN-WHxp1TI4ZcNw-1
X-Mimecast-MFC-AGG-ID: v9bcfdPmN-WHxp1TI4ZcNw_1785400616
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-930f5da3467so219483885a.2
        for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 01:36:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785400616; cv=none;
        d=google.com; s=arc-20260327;
        b=Iw2zhsU6oGH+1qxs3KuFBc6KSAoVa43mapCJr3LOeMPdRq/yPOU3IKmhiuKzNAshQz
         MqCtFPaiJO8F9X9nXCDM3KXkkRzURwwsygVHXzOC8yCgnPBxficQ95qL0Edi98ir2wKO
         Ab9dX3NVL2iUUUvFVGYdxl3sm4WutF2zsY33zbAsayPITzQVSW/ASYMWtYWZSCbe9NkG
         y4yf7WZ0ypE/WIj9rHiz9mODUbOMudUsY5YukId6IvCNZwFBJoncsh6L5zxWch1ubxVf
         9SbphNdfEYbpKy738o4WlyEwqAon57l3i0LamjCC9IYs5qlxmf80qB+xHUi2rJN/Ocmr
         jqnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=BJTv0GnfJX61s9kcSSNJonT/FIIHCaZ/xJUeqJ7IGYU=;
        fh=fItrUtV5UsY1KSNx1ZNnzv3miYMbODbRRQWQ18AP5Zc=;
        b=ETCHBAvP83vTdV8Vm4WJBmGwIhZ4PSCRbfwxYloAPUJr5+lF0Ke1AkEzWrhkgOtcq/
         rE7g0yZio+PFYQ6AQnJj+60tM+2Y1JDooA1Y+cjHAPSysWRLN7HY793hHiSTW802Ot4V
         c5uwwSpqeUOlOV3shacQNn2StAh1hgl1y/SretLRRYvyxARh5WPu5pyNzRnNq8tqwPk1
         MMN+ivWRXlKTzkj3B9ZKJMjoojbwKCv7Wi+6Yz63dif0bAfB62++iU5tndwn1qmG8oEh
         ZbLTwXZl3/ojuiHqAYaG/3ZXeLaKJW1xyJmst+XV/wBFjuzfNGM2MSoP4f3u+b2Vz75y
         NEBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785400616; x=1786005416; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BJTv0GnfJX61s9kcSSNJonT/FIIHCaZ/xJUeqJ7IGYU=;
        b=VNx0kEQl3G0LERokU2Lzh7lOsKPF7EbB9nUmf0CgO080ZR40fahD1XKZWFl/4568wI
         PV/LUYVhQZGNBuzIhW8DrwbsYUPu2O+OLqSoX70pHQNfiBm6Wiqm+h7opaU8Xsf4phvs
         m4237aGRq7EjdS1F2GWTPf0eaBb2riCp6Mo8SDKEd/dzwQ1m7dzjXODTWWpTebTcrgCc
         NVLLHpIvLTxetLmqcPsWphfdue9YvepNOal290UY5GblJmABbFSXeOOlnHN27dJrONNw
         v6zqXMln3Wnio+RJSvkza2i5dKkTTloDAbcUM2+K2iDAdMSX1Ta+lmKNcLiq/T+xC7oi
         cfCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785400616; x=1786005416;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BJTv0GnfJX61s9kcSSNJonT/FIIHCaZ/xJUeqJ7IGYU=;
        b=JMr881WX86KwGhKHijSam5mF5qOXr6xG9xAoPkzE5e0mYVz68HzvktuZ94P02EyuKX
         keobR7nQA4YzgDXuetLF2R2VUSvChZ/D10lBz3kQzaOpO1qkxuvsJAJyVWGiDiWl3wfH
         063bEoatrDra3Ke99Cfnz0ALd0OAXfn2UZ/wAj6NRcLrnrYbU2G4xIThPVg69NrlXng2
         P+Mpzeje6pKZbRqAmdL88i+wXgPOWxynZwc5KqygJ8Fk69bTFWdf+AefC90DnbgcWeTG
         PwAh7GDLMrIFnuhfBYN2smjxhldLE6itVp5GHzMPB3B9LrSvdMXEWu07I1hreHv8jcYk
         +r5w==
X-Gm-Message-State: AOJu0YzEN3p0kdZksGxr+Y959pVr7i5Dso6J3qaq/cilvfm8ByBjyMhn
	Y60SgvwoDsMmPU4MFBIAZ1InIJzo89sJkR1uTxHJa4AwGnJCIFIeUP+3aZ+BkP0t2Mhm58V+W4+
	HfrIiRVfB/zY3utghpqY+rTjI7ExOzlOT31R0/FlWfnndMLY5tMkJKvQ3Vsmpe3ipVnjiTZLJRw
	r1smNQDZ3QUEn8k4Xqhwgtg8v0zYDr
X-Gm-Gg: AR+sD12+CkaVGSsWH5tNSgvrcOIgGzwZDVT9zpE0KweCsDmGNn8gycw6pdDTmCqLewd
	W3ZZ5ASpxLMZOTT46cuwXJJbAu5HUKHPSFZG43nqCpRAlOLrV8Z3y/nIxdHz/iycL2L5dgLwy/f
	eh/P90VCXN144Gp9XFqVt1YoLW3YgIf4y85aAmDKMmCImWn6W41xi6veM=
X-Received: by 2002:a05:620a:a2cc:10b0:92e:ff34:17fa with SMTP id af79cd13be357-934872091femr118058785a.84.1785400615752;
        Thu, 30 Jul 2026 01:36:55 -0700 (PDT)
X-Received: by 2002:a05:620a:a2cc:10b0:92e:ff34:17fa with SMTP id
 af79cd13be357-934872091femr118057885a.84.1785400615370; Thu, 30 Jul 2026
 01:36:55 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Jul 2026 04:36:52 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Jul 2026 04:36:52 -0400
From: Sergio Lopez Pascual <slp@redhat.com>
In-Reply-To: <20260729171747.CF28E1F000E9@smtp.kernel.org>
References: <20260729014223.17937-1-slp@redhat.com> <20260729171747.CF28E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 30 Jul 2026 04:36:52 -0400
X-Gm-Features: AUfX_mwWn6FM8OQ5T3rWsg7bRWtcRdi_hoypiqsqKjNmYcBnvUPorGF-Sbs2aLI
Message-ID: <CAAiTLFVTN-KWF3hzPxB-RR6SuLF+9JAWbrLA2um7ZkgXUcdxAw@mail.gmail.com>
Subject: Re: [PATCH] KVM: have hva_to_pfn_remapped write-upgrade PTEs
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

sashiko-bot@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>
> Pre-existing issues:
> - [High] Incomplete fix for VM_PFNMAP write-upgrades, bypassing already-populated read-only PTEs
> --
>
> --- Patch [1]: [PATCH] KVM: have hva_to_pfn_remapped write-upgrade PTEs ---
> commit 8ea7b308a68b0aabea9b703efac8ec9af51170aa
> Author: Sergio Lopez <slp@redhat.com>
> Subject: KVM: have hva_to_pfn_remapped write-upgrade PTEs
>
> This patch introduces a second fixup_user_fault call to handle
> write-upgrades for VM_PFNMAP mappings that install read-only PTEs on
> write faults (such as DRM GEM BOs).
>
>> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
>> index b4baa69a55402..b7fb9278f198b 100644
>> --- a/virt/kvm/kvm_main.c
>> +++ b/virt/kvm/kvm_main.c
>> @@ -2958,6 +2958,8 @@ static int hva_to_pfn_remapped(struct vm_area_struct *vma,
> [ ... ]
>>  	r = follow_pfnmap_start(&args);
>>  	if (r) {
>>  		/*
>>  		 * get_user_pages fails for VM_IO and VM_PFNMAP vmas and does
>>  		 * not call the fault handler, so do it here.
>>  		 */
>>  		bool unlocked = false;
>> +		bool write_upgrade = false;
>> +do_write_upgrade:
>>  		r = fixup_user_fault(current->mm, kfp->hva,
>>  				     (write_fault ? FAULT_FLAG_WRITE : 0),
>>  				     &unlocked);
>> @@ -2969,6 +2971,17 @@ static int hva_to_pfn_remapped(struct vm_area_struct *vma,
>>  		r = follow_pfnmap_start(&args);
>>  		if (r)
>>  			return r;
>> +
>> +		if (write_fault && !args.writable && !write_upgrade) {
>> +			/*
>> +			 * VM_PFNMAP fault handlers may install read-only PTEs
>> +			 * via vmf_insert_pfn(), deferring the write upgrade to
>> +			 * a second fault. Trigger that upgrade now.
>> +			 */
>> +			write_upgrade = true;
>> +			follow_pfnmap_end(&args);
>> +			goto do_write_upgrade;
>> +		}
>>  	}
>>
>>  	if (write_fault && !args.writable) {
>         ^^^^
>
> [Severity: High]
> This is a pre-existing issue, but does this placement miss the case where
> the PTE is already populated but read-only?
>
> If a guest first reads from the DRM GEM BO, triggering a read fault, the
> DRM GEM fault handler installs a read-only PTE. If the guest later attempts
> to write to the same page, hva_to_pfn_remapped() calls follow_pfnmap_start(),
> which finds the read-only PTE and returns 0 (success).
>
> Since r == 0, the entire if (r) block containing the new write upgrade logic
> is bypassed. The code then reaches this check and incorrectly returns
> KVM_PFN_ERR_RO_FAULT instead of performing the write upgrade.
>
> Should the upgrade logic be placed outside of the if (r) block so it can also
> handle already-populated read-only PTEs?

Yes, I've confirmed this scenario is possible. I'll send a v2.

Thanks,
Sergio.

