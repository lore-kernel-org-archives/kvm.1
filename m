Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.203
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795498300;
	b=kdFZlnqwb8K5zt+lKkwkjHUM7AHtGHZQpa7VvYErFWL/N/i4yO2cfmpS9cIzdZEWWdRS
	 VpJrR2DZ06Yk7TZvhvpwc1620n5irep3/9A4KdKAOZWhzUV8y99GK16aq594UFgjiCHUI
	 x7jPEW+kdyGoNhPZ38aYCnwBav/FeDjsVnHLRohKj+I9su/8/cvYhui2UOBkmJ6aoMeFo
	 BWuOARBsbAfEvXAr6iBPC5CMYFu4CpyjOSvR80z+wBe3fOBUEdx4sQ5x39qlUKGlJUSdl
	 C6lUIMEAOILlMdTxQcV69h+6G/SctzVJYjHjdq5yVorQQGguKjaScoCUhAZrzfdQd+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795498300;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=MHGUggYwA3gp5Hl40fLruxFZvaBCGWgXTV8JidRQovM=;
	b=eJtHNFMML0G+hSuacUR6hFSMAVp/22skWAuix0S6YiQzNB6fgwZ4b8ciIiA8F4jOb0YY
	 61pnJtdfMUhuNZeZQwesTrfEWO6u01Plz2F2z32za1P5TJrT+3LcVKjvHwT2LyzYRiKv2
	 YKvYW8hrEyHdNc3LNoSSu2mxiQyN0c+y9EbZvLWy3bFM09cGHLCUK39E50icRbZpZgdda
	 QuCShYCD5h1YyjEqUAInGTsY56hzkNet/BTcpr4YzDROLnO/GtS0/EAbm25XIVhZb1g41
	 aYcM+L3pild10RWbbDgTWtY26v2sDePenWux/CM3j4+19wTImtn/6o4MjRANNU02nYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IL2OexmH;
	arc=none smtp.remote-ip=74.125.227.203
Received: from mail-pi2-f11.google.com (mail-pi2-f11.google.com [74.125.227.203])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85194606A321
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 05:31:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85194606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IL2OexmH
Received: by mail-pi2-f11.google.com with SMTP id 41be03b00d2f7-cde795fea95so914092a12.1
        for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 21:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795498299; x=1796103099; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MHGUggYwA3gp5Hl40fLruxFZvaBCGWgXTV8JidRQovM=;
        b=IL2OexmHvHFKYHluRIKtNYMqUEc5MTXHSaKYpwbh+Hj/xk9TMIYcyvQeRcQZBqGbLx
         JvrRAPkJzFw22AtCCgQtKJTaef7PeUHoR84RpieUxP1PXls7QB3w9/r66UxCDpukSGB4
         ReTmmwpM6RYXhALKZRMzc1Plj6nB8PoGLzkzXTS+Cgj4gsrYY+Ya7onI1BmnTaOLPyIn
         3xdPootTOygbq5YGD5Gugw0IPDBsx29+1QlBAEBZD6otGftJu8Rmcb7+uvXGQ/kFU7t9
         t1JTqcWTEoBb/hXzW9xSJk83RaFgh97gpXTz1R8zNB0szVMIZ3akveKMEiYVkKT+PbyA
         +95w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795498299; x=1796103099;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MHGUggYwA3gp5Hl40fLruxFZvaBCGWgXTV8JidRQovM=;
        b=sLOmJ+JEXbzZunRNxAmZo7HUdmsuiAqOnDuLVbL4FO+UimN0O9LKs0VqHO6cJVVYv8
         poopoD8TbsjLZYFhQX3BeZi7Wk01+zfwx+5qA79RGGky4ueYn7NEc65ab5r0+FcrMZNi
         CT+OJzzBNvfO6BaUkNvqQVCX1+vHFICtp2I9BHv1jlUMa5S0mkPQehQE7NwhiCkwDAyb
         XR87XeFkRhw2x3Q8HCh4Wdfb46rwRgUvOAly9vXY6mSrY9qbc9mWtWwYZta/l4+O/LXu
         SXml2zC+VjXMXrS33wtcMmbdUCBQVfDoOjihQrtTD+Lu1+6Gs4n8DWPetupd9HVNgQwV
         Z6+Q==
X-Gm-Message-State: APuU4Z9xJDfntOIs+SRFol7PtKUO1HZON1mqGjlrTvnfcefQNZw8W3So
	+i9M6q4AbRdNKEKuskw1COSCOYrKPG1kj3EVsZ2FNrOY7zhoEfXuC1/F
X-Gm-Gg: AZFdTZeQ5lcjmOCmK65UEp1Vb/uH/SOK+PxlFCtjBR32dss3KFJUmkYdfMLM+1S8Vpp
	BlkJ1eonw6qNTnodBhz9mDDG5+kprHQv2sBEEAfJdL7N3LPD8hwjbhCboN+WRTOtnobkb/V8BxT
	Vait3bo1B1Yv86zXPl6vOsoEWUmGC7KZsHIfDCp1obWJFgG0pWVXvNh6WaJqfX8ea17PgowQCgK
	cxEcag60DSHRzjUIJ1RAk9vpGIBrt7bH5stgsSyPyL7wnt1jWmkWUvz+9ptwnBTmux+25iQHJsq
	EqsqTYS9dzlPJEpxp+DSyDNcf79K5x2vRpjduKshTskeZ+qAMrt/XVd6zxXEqnAH+/LCb0smAo2
	p3zRzhcE1iQIF/haHeYhsI69d6y63+CTuMUlAGHk7WIGNH3dzZjOsQRS3sitjrgrstYkkr+Mrqc
	w/NGXu7MNalYA7QAKAN335W+jnH7Sl83Rd2y6We/WlAqqq/58PqLj9ixCWi6vFaYPFQVpSW0I/j
	zvFYUtQdAbZXxIBCc8PWJvPDMDX5FJA/Z0al+H3A5iM18O8rejya0WChKoDz2zEeIVGGEi02piM
	HP5e27Ab2pN/XNUq6UIcdsWXuGC/CVLXV6xLJD+OyRr2YawUunET
X-Received: by 2002:a05:6a20:7d9b:b0:3e0:dc12:8908 with SMTP id adf61e73a8af0-4014e25b4f1mr12376756637.81.1795498298665;
        Mon, 23 Nov 2026 21:31:38 -0800 (PST)
Received: from [192.168.22.174] ([114.246.237.251])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6c9c7dcbsm6562442a12.0.2026.11.23.21.31.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 21:31:38 -0800 (PST)
Message-ID: <286b4604-fb68-452c-b131-d3847669726f@gmail.com>
Date: Tue, 24 Nov 2026 13:31:29 +0800
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 RESEND 2/5] KVM: riscv: Avoid THP adjustment for
 existing 4K G-stage leaves
To: Jinyu Tang <jinyu.tang@linux.dev>, Anup Patel <anup@brainfault.org>,
 Anup Patel <apatel@ventanamicro.com>, Atish Patra <atish.patra@linux.dev>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Andrew Jones <andrew.jones@oss.qualcomm.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Yong-Xuan Wang <yongxuan.wang@sifive.com>, Nutty Liu
 <nutty.liu@hotmail.com>, Jinyu Tang <tjytimi@163.com>,
 Gong Shuai <gong.shuai@sanechips.com.cn>
References: <20260815102833.864330-1-jinyu.tang@linux.dev>
 <20260815103245.864925-1-jinyu.tang@linux.dev>
From: Gong Shuai <gsh517025@gmail.com>
In-Reply-To: <20260815103245.864925-1-jinyu.tang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jinyu,

On 8/15/2026 6:32 PM, Jinyu Tang wrote:
> When dirty logging is disabled after a G-stage PMD mapping has been
> split, the fault path may see a 4K G-stage leaf while the backing host
> page is still THP-backed. The existing kvm_riscv_gstage_map_page()
> comment says that this path should update the small leaf and leave huge
> mapping recovery to a later ioctl path.
> 
> However, transparent_hugepage_adjust() runs before that G-stage lookup
> and rewrites the fault GPA to the PMD base. If the original fault is not
> at the PMD base, the lookup can find and update the wrong 4K leaf.
> 
> Check the original fault GPA in transparent_hugepage_adjust(). If it
> already has a 4K G-stage leaf, skip THP adjustment and keep handling the
> fault at PAGE_SIZE granularity.
> 
> Signed-off-by: Jinyu Tang <jinyu.tang@linux.dev>
> ---
>   arch/riscv/kvm/mmu.c | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index bfd6168ebe30..2fabcd409991 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -500,10 +500,21 @@ static int get_hva_mapping_size(struct kvm *kvm,
>   
>   static unsigned long transparent_hugepage_adjust(struct kvm *kvm,
>   						 struct kvm_memory_slot *memslot,
> +						 struct kvm_gstage *gstage,
>   						 unsigned long hva,
>   						 kvm_pfn_t *hfnp, gpa_t *gpa)
>   {
>   	kvm_pfn_t hfn = *hfnp;
> +	u32 ptep_level;
> +	pte_t *ptep;
> +
> +	/*
> +	 * Keep the existing split G-stage leaf and update the original
> +	 * faulting 4K page in the vCPU fault path.
> +	 */
> +	if (kvm_riscv_gstage_get_leaf(gstage, *gpa, &ptep, &ptep_level) &&
> +	    !ptep_level)
> +		return PAGE_SIZE;
>   
>   	/*
>   	 * Make sure the adjustment is done only for THP pages. Also make
> @@ -730,7 +741,8 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot,
>   	 * so do not promote them through the THP helper.
>   	 */
>   	if (!logging && !is_hugetlb && vma_pagesize == PAGE_SIZE)
> -		vma_pagesize = transparent_hugepage_adjust(kvm, memslot, hva, &hfn, &gpa);
> +		vma_pagesize = transparent_hugepage_adjust(kvm, memslot, &gstage,
> +							   hva, &hfn, &gpa);
>   
>   	if (writable) {
>   		mark_page_dirty_in_slot(kvm, memslot, gfn);

Thanks for your work.

Tested this patch on v7.4-rc4.

FYI:
https://lore.kernel.org/qemu-devel/95fe4c53-fe13-4e0c-abbc-bbb546850560@gmail.com/

Tested-by: Gong Shuai <gong.shuai@sanechips.com.cn>

Best regards,
Shuai

