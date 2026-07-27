Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9999E38F620
	for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 15:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785165951; cv=pass; b=OeQdo8LRUBcayUrQHv7P+gNmp+qFHXmohSwrKJ2RNb0RP/kzHo3p4U2V/AKPjRteg5tR5Qx9QldFnrY8mSy6JUsdOwZ3r/DIEkEdxjIzv2VAoMRTO//tdoEK5M1FsUMT2j4OnHdeouKLW5B649pCX49fvQWvMjIgAux3fDcMGsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785165951; c=relaxed/simple;
	bh=aN1lvwhg4cIpsXmW+qcL7ksUyBdvhNo8IXukcEIFeOA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kusT8iHv6no6+styLFgfzcKAcgXalqMNs8feAjT/KkUqZSv1IoXLvZKOXhe7lpvmb/R33qhk9mIqVR4GNJEI/3KMerbijSyT8huo/T7qlyhtYLnx0HvvPwSPNN78RxEanj3UK91BekZO4/cD+C8Bu1vZtv48woZiKana2bNs0ek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=njufSEk4; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="njufSEk4"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so2222390a91.0
        for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 08:25:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785165950; cv=none;
        d=google.com; s=arc-20260327;
        b=X2l9MebxJplejx6GJQ0q3hFi4+kMtrtOSsbVCgfQdkHhReEVlME8QHikynQhcMT3Ud
         qQ1DUA32TznK8S/Z8YUfUB6vhFIg6aQKl3f24jVQEgJRZ837yV41JyFRTy9i5YVHGdAP
         WnKDWBTz8SVUvBHiLX4ox/DRexZ4ITleIUZEbYqi1+tfGpYjymqfZYPxJDSuo36qQkwW
         VYUDQDCFgKH0RhlCWEmjoOvfpPvJqKApc+Ji18fEewzsfXZRwTM/1VRU6xBssK+KSlVk
         y4+fRLsCh0J52iajJDoj+i9WmhnfOc2nlSwx3rx87DM/ngHnmInaCwMnxwch3uRd0tK0
         gNWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=31CIetStzX3TzwM8tOJbNAHIf31515DPG9HVGktRb6E=;
        fh=0jr4E/1rkbX5UFRgK5qw3SdHBMnlxZHJK5M9+F2kHjQ=;
        b=qVmO6JS8K9Ze781WCYPEsMc+NKp4eSo/4V0tyqwdnzZvnmZW015Qk9MZbBpBNq9lHS
         GQ1Vxp3x9tKpd7AZumqcHFApNysfr7hPG/+6AGEaJI6J5bVaxgsR7OzhqKBh7Ff+8jgF
         NsdDVH0wcgJU6yNEoLgmxSjYV1ZEwuWr/gAj8m+uVHdVx1XYaC9WLlD93kn7/jxAiL6C
         7IXKa/P91kJd08HFHd/3QLIdWvgY0WUXuXPLmc/rSsjRXqOJxic7i9WMwPFYgiKiou8f
         TRs7Ktmfh7iv4GeQPl4C15GxfM2HQ5nQ1AGtDG6LcLUVHEaJVDI0qTGp0I1UDv/QOyh5
         xWfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785165950; x=1785770750; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=31CIetStzX3TzwM8tOJbNAHIf31515DPG9HVGktRb6E=;
        b=njufSEk4ZTWKZ1KuV5Co4+rZ72UY1QRyoYtfu/DtpUsKI7FqpJPy24S50JKqMafaYv
         RaF36GizuEoAsCgWFhgSOQLNQffyVubmj9RJRjfngVh72fOksGWknySDLodKXpIK6/C+
         l4uRsNSf/qR5TZZjQT3NUCPL3I2OQZOZnTKhMdWdfi1WKIbq9MMycTcCHiI3v+YwWzn4
         ieEy6Z5UU2Stkrqyxh+YBPSnEQj9fyb31TZqRUNNGiWnYHgHNxdizQIJnrb84Jl9W6nM
         A+IV8bIxkJspxYg6rUMRuhmTnZ/DJGkTOj1E22lZus5YvYzqW5iOzbPJKrYhptCszZCV
         mdag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785165950; x=1785770750;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=31CIetStzX3TzwM8tOJbNAHIf31515DPG9HVGktRb6E=;
        b=jd7dokHb8t2Y1evJAWrtM8C7QvlaBPOrRtq8ZC4E/iTsNYONitcM9np8rIycsgljOg
         yUOwoKAjUqveIcm+reCYMTcWZlUXmwIqsRCxamFxQCXURSB6aYca7F5Hd67e/fBLDrls
         YD/Q2QmG9C335NHaidMjV3fx9NJPeWj436mrcwvQEnfJm4i1TQYfKtgP1zTw2LnkGJBu
         oPTEoFNIqqztv872zhmUVoQQVi7fqVMXgAVCozgWZaspDFylsKfdGEbTU7alViAFajTN
         kZLOxrlmrZSG48I0sHOroS0/FMyqmmBxya74PnGux8uyWKrIsOwE8Iqppk7/ZJv5miXW
         ezOg==
X-Forwarded-Encrypted: i=1; AHgh+RoaxkyfIjwv9K8BGGlaEZkTgrwpGzT9z86aH56DdupFIHlB3ElZlPs5xUeav5MuRvfQogg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4jSu3acWajuDXcGkddzwg0eif7FslCcleCBPSgbIYMqmaxSOs
	7QfP5YyxTPtIa20MhuDtzXXc7pSNS6KXSS0VHNGKlI2jV73l8eLWmq61QYfmUQJdcLiUDVJ4x2p
	6lKMLXyvn0JJV3UJEhve/4JKGN9AleQ9j1IsueTVq
X-Gm-Gg: AR+sD13dQtmzlNv+rqiQmmyWEuzxjJYdXq+L9xHumdm/pEmkK8bd+diWqoE3speWg2n
	X9J7JXT4GrsCXWwgUfGHOG8hOV+3V/VyoWvwXreGcm4BONsAi+KRgYNJHToTxjSRmp+xH/btKqJ
	CpqTaW5gTbu5KSJJRGh89q6PkC3a1txQ62YB1yF73doD/9dOB5ZeKRtLZ53RNiG23of6eYu7z3v
	rXMU+/WvVWbWXnLJts/mI2ywDPiWe53bkLa42CzTrjuQnTSjKIWqb3gZjaYMR85d+apa4Hysyxl
	gHfWFmiwCgExAHzW5IOR25Zm77EJQmGZyITu83O3DZarrZmTwNVFF1Vrh7wI2y15xAtjDVpV/hj
	A2NtrSY/CJP0CnqOAsyAVaazWjGS9ujbV2Wpz2F8jcRI=
X-Received: by 2002:a17:90b:1fc4:b0:387:e0db:bc2b with SMTP id
 98e67ed59e1d1-38f298a5f8dmr7269755a91.43.1785165948891; Mon, 27 Jul 2026
 08:25:48 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 27 Jul 2026 08:25:48 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 27 Jul 2026 08:25:48 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <amdqJtKey_zX4-Mf@google.com>
References: <20260723210811.72720-1-seanjc@google.com> <20260723210811.72720-8-seanjc@google.com>
 <627eda4b-c084-4cd8-ad3a-3b3793feae0d@intel.com> <amdqJtKey_zX4-Mf@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 27 Jul 2026 08:25:48 -0700
X-Gm-Features: AUfX_mzWYcnSjvvZ7YY8Cs7PDecKksNWvOG61nC9VzRxcHwogNJ47J_oW4kqtDY
Message-ID: <CAEvNRgEn7Cjog12OWxAfwk8AHTtSy0ndp=-DUj2pv6C5iDTd3A@mail.gmail.com>
Subject: Re: [PATCH v6 7/9] KVM: guest_memfd: Rename prepare() hook and
 Kconfig to make_private() / CONVERT
To: Sean Christopherson <seanjc@google.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fuad Tabba <fuad.tabba@linux.dev>, Michael Roth <michael.roth@amd.com>, 
	Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> On Mon, Jul 27, 2026, Xiaoyao Li wrote:
>> On 7/24/2026 5:08 AM, Sean Christopherson wrote:
>> > Rework guest_memfd's prepare() hook into a more accurate make_private(),
>> > and rework its Kconfig from PREPARE to a more generic CONVERT.
>>
>> > This will
>> > allow x86 to share (pun intended) a kvm_x86_ops.gmem_make_shared() hook
>> > between the "convert to shared" and "reclaim" flows, which are one and the
>> > same for SNP.
>>
>> Does it mean in the future we will introduce something like below?
>>
>> #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
>> int kvm_arch_gmem_make_private(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
>> int max_order)
>> {
>> 	return kvm_x86_call(gmem_make_private)(kvm, pfn, gfn, max_order);
>> }
>>
>> +int kvm_arch_gmem_make_shared(kvm_pfn_t pfn, kvm_pfn_t nr_pages)
>> +{
>> +	return kvm_x86_call(gmem_make_private)(pfn, nr_pages);
>
> s/gmem_make_private/gmem_make_shared, but yeah, that's the plan for the in-place
> conversion series.

Yup! Did this.

Should be able to send out v9 today, just need to run some tests...
