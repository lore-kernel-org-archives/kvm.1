Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.92
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792582239;
	b=PiehPUjLSL+n6gpW+UKZuatJqmHSdwFK+nJPcJuYPzSOXVeNKvGXCKiKLujccW9scWgM
	 OMV7+fxJreXC3q+k41GxN1h2MJ25Xv1yHObeaL5H2bYafIp13kuq8omt/SiBEFqCqi8PQ
	 HvBHUVseYYtKUOFAnDYh1l2xrt3QE2wWTUA8ldMLl/xwuO/xrHw4pfej5/xUNoh1di/mQ
	 cpQW3T/OoVUZYObw3yz120drni2fYWUviyBMLB7WBrBBGmhutgXYBY+CWUIOyCjPx+nCz
	 f36cALE7vcPcaPiVs8w7d2MjzrPRsF7XC92DmkamuHYM5udfrYMnxCXPjxhHjs+73FQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792582239;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=U+xSPnvmF/tO+Fgf3pJ9qhNAxgNa/gXXKtkwmbQs8oM=;
	b=aO7g1lYxsij4MGUtzCldl9OUl3uyLvx9fTJ1bYGHtiZPX/Lzq7ws1YXmlPxwHDLgqo7w
	 qF9WOaSkUCT5YgWph3cnFPl3zpsbPBuM/C/10TIo/VME+GUC84DG5+kF6mx+KuDuUMIYA
	 32J+TWEXGqMRRMlHQHtLpAO0R17ko1QBBw8K/G3ns9R7jGtfl+bO6v5NjEDb1eJr7XBJ4
	 z9Pm9mlZkvJ0RIssN9viwziFPpuhopQ8DdwvMd5096l5LV1ayC+/sbH+cTMDbQUYEfdea
	 NrCeqxOAjjmYC+0ysZTu8TYcGen0wZH+IIWWi1FCKcc2W0GVHtL4ZTPoiUUQ0P+LPfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=peV2frh8;
	arc=none smtp.remote-ip=91.218.175.92
Received: from mta0.migadu.com (out-92.mta0.migadu.com [91.218.175.92])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E64606A31B
	for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 11:30:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7E64606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=peV2frh8
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ajoLYE5AD2heyAC44s3QWW8/SJdTozUgA/AhWcBRkvo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792582235; v=1; x=1793187035;
 b=peV2frh87rolLVSFnvECmmtCIKSTBix8AHi94IGRwH2+Zplz/8TmlcfbFbtgWK++PPc/FcIX
 LF4vX1JfVq8eQAPn3Km9B4spHNUfS/5G43hyqiZ3M2xqyrStXmaDXJ780crtyJQOZLG9IS6I3x8
 kHbmK8qsFXefL7HyACclAzCE=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 591aea82344d2dfa;
	Wed, 21 Oct 2026 11:30:20 +0000
X-Mizu-Trace-ID: 591aea82344d2dfa
X-Migadu-Flow: FLOW_OUT
From: Jinyu Tang <jinyu.tang@linux.dev>
To: SeungJu Cheon <suunj1331@gmail.com>
Cc: Jinyu Tang <jinyu.tang@linux.dev>,
	anup@brainfault.org,
	atish.patra@linux.dev,
	tjytimi@163.com,
	inochiama@gmail.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	andrew.jones@linux.dev,
	pbonzini@redhat.com,
	seanjc@google.com,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] KVM: riscv: Set Accessed bit in dirty-log write fault fast path
Date: Wed, 21 Oct 2026 19:30:10 +0800
Message-ID: <20261021113010.2476783-1-jinyu.tang@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016101458.221648-1-suunj1331@gmail.com>
References: <20261016101458.221648-1-suunj1331@gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Oct 16, 2026 at 07:14:58PM +0900, SeungJu Cheon wrote:
> @@ -591,14 +591,15 @@ static bool kvm_riscv_mmu_dirty_log_write_fault_fast(struct kvm *kvm,
>  			dirty_marked = true;
>  		}
>  
> -		if ((pte_val(old_pte) & (_PAGE_WRITE | _PAGE_DIRTY)) ==
> -		    (_PAGE_WRITE | _PAGE_DIRTY)) {
> +		if ((pte_val(old_pte) &
> +		     (_PAGE_WRITE | _PAGE_DIRTY | _PAGE_ACCESSED)) ==
> +		    (_PAGE_WRITE | _PAGE_DIRTY | _PAGE_ACCESSED)) {
>  			new_pte = old_pte;
>  			ret = true;
>  			break;
>  		}
>  
> -		new_pte = pte_mkdirty(pte_mkwrite_novma(old_pte));
> +		new_pte = pte_mkyoung(pte_mkdirty(pte_mkwrite_novma(old_pte)));

I tested this on QEMU 10.2.1 with Svade enabled and Svadu disabled.
With dirty logging enabled, the test clears A through page-idle tracking,
write-protects the page with KVM_GET_DIRTY_LOG, and resumes the guest
write. The unpatched kernel times out after 10 seconds, while the same
test completes with this patch applied.

Reviewed-by: Jinyu Tang <jinyu.tang@linux.dev>

Thanks,
Jinyu
