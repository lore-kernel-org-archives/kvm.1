Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF8235A93C;
	Fri, 31 Jul 2026 06:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785478306; cv=none; b=bkis1dA6wPEXnmVljelZ7aqvJ/HSbgQxskgBAayzB/3m+XoLeKPeJFlgbg0kZAjScpta+5UHue9bDkhH42+DXTHBuE5A7sdHN4JWnLpT1509NgIZ7Qa27ylAY+dyWG/zLiglLdooJ8iy0yYNG2cEfop+9gwiAIfAvi+zuxZYPcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785478306; c=relaxed/simple;
	bh=63diiC56Hxg7jd1MjV51r83N2WaCL0G918kWhD8NevY=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=CbKa1VZVwt745IH/AHdK+wuksnBhsMQTCTas+AScqnJOFhx0oSI0gikheyI/AbqdlCpiPqyzR9pgi/eAEZEwGPk3/pUer7HxuhVBwXQmnzHW8nBwKZ3s4f14gEJGO4hRqQHqWqQtfmh8vaAFHW91czOr44AM5jw7mDRP+CTK+4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4hBG151hcmz56S5Z;
	Fri, 31 Jul 2026 14:11:37 +0800 (CST)
Received: from szxl2zmapp06.zte.com.cn ([10.1.32.108])
	by mse-fl2.zte.com.cn with SMTP id 66V6BTq5055955;
	Fri, 31 Jul 2026 14:11:29 +0800 (+08)
	(envelope-from wang.yechao255@zte.com.cn)
Received: from mapi (szxlzmapp03[null])
	by mapi (Zmail) with MAPI id mid12;
	Fri, 31 Jul 2026 14:11:30 +0800 (CST)
X-Zmail-TransId: 2b056a6c3c92204-5b4d3
X-Mailer: Zmail v1.0
Message-ID: <20260731141130967G9r8eUgi_oMRjksjgXyRf@zte.com.cn>
In-Reply-To: <CAAhSdy0_dCHC+ZVG7HZdtUxZWWX_KG3YfN=ngVdpy-7_pquUFA@mail.gmail.com>
References: 20260701120954.129873-1-wang.yechao255@zte.com.cn,20260701120954.129873-2-wang.yechao255@zte.com.cn,CAAhSdy0_dCHC+ZVG7HZdtUxZWWX_KG3YfN=ngVdpy-7_pquUFA@mail.gmail.com
Date: Fri, 31 Jul 2026 14:11:30 +0800 (CST)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <wang.yechao255@zte.com.cn>
To: <anup@brainfault.org>
Cc: <kvm@vger.kernel.org>, <kvm-riscv@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <pjw@kernel.org>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <atish.patra@linux.dev>, <alex@ghiti.fr>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2NCAxLzVdIFJJU0MtVjogS1ZNOiBBZGQgdGhlIHNwbGl0IHBhZ2UgY2FjaGUgZm9yIGlvY3RsIGNvbnRleHQ=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 66V6BTq5055955
X-TLS: YES
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Fri, 31 Jul 2026 14:11:37 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A6C3C99.000/4hBG151hcmz56S5Z

> > @@ -54,6 +54,12 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
> >         kvm_destroy_vcpus(kvm);
> >
> >         kvm_riscv_aia_destroy_vm(kvm);
> > +
> > +       /*
> > +        * Free the split page cache after all vCPUs and devices are destroyed.
> > +        * At this point, there are no concurrent accesses to the cache.
> > +        */
> > +       kvm_mmu_free_memory_cache(&kvm->arch.pgd_split_page_cache);
>
> Better to do this in kvm_riscv_mmu_free_pgd()
> 
> Regards,
> Anup

Thanks for the review. I'll move it back to kvm_riscv_mmu_free_pgd() in v5 version.

Regards,
Yechao
