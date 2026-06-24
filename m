Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D1D3AD52A
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 09:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782294096; cv=none; b=UTrD5GFSlwOnuAGd/DirOhirGFTu5vdtFjYu7zDTY79c4KGABDpeKX1YQaarouHf8Nhs5n8Dryrp5DC+BA353c1NsYMC6GI2NKaU8mMRaiVbgZ1PhGdEcmbe8xXzBKG828H7p4zLENCVoXDStsvZISe2Eb0qGZm0WchdcVKCzSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782294096; c=relaxed/simple;
	bh=ULWxdz0BIFr48ZIJvle1NnWZ4VMXjrMMFeXOIxwc4L4=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=X0WehqSATsSDoddwkEnjpjvOgplJbE3P6Ligv24q9QOKuRaPJaqg4TQ2Hj/czVwTPXMWPpdwmtjAkKRGVWAiViHOSqYrtV4qx417jwitrzm4o8zHJrxOvWKFhXYquBdXnfjvVDVF+j0+umSb4K4H6PyUcsQl95iSkituXlvaiqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4glcQG29Byz57HS0;
	Wed, 24 Jun 2026 17:41:26 +0800 (CST)
Received: from szxl2zmapp07.zte.com.cn ([10.1.32.52])
	by mse-fl2.zte.com.cn with SMTP id 65O9fGu9062508;
	Wed, 24 Jun 2026 17:41:16 +0800 (+08)
	(envelope-from wang.yechao255@zte.com.cn)
Received: from mapi (szxl2zmapp06[null])
	by mapi (Zmail) with MAPI id mid12;
	Wed, 24 Jun 2026 17:41:19 +0800 (CST)
X-Zmail-TransId: 2b086a3ba63f568-5af22
X-Mailer: Zmail v1.0
Message-ID: <202606241741193492lCGyiENBlJMfZwNzW519@zte.com.cn>
In-Reply-To: <20260624083542.DBAFA1F00A3A@smtp.kernel.org>
References: 20260624160054463wcDvJaMoydSggcNOWgcfB@zte.com.cn,20260624161128723A8RgX9GQcthwS3so76Ou2@zte.com.cn,20260624083542.DBAFA1F00A3A@smtp.kernel.org
Date: Wed, 24 Jun 2026 17:41:19 +0800 (CST)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <wang.yechao255@zte.com.cn>
To: <sashiko-bot@kernel.org>
Cc: <kvm@vger.kernel.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2MyBSRVNFTkQgNC81XSBSSVNDLVY6IEtWTTogU3BsaXQgaHVnZSBwYWdlcyBkdXJpbmcgS1ZNX0NMRUFSX0RJUlRZX0xPRw==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 65O9fGu9062508
X-TLS: YES
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Wed, 24 Jun 2026 17:41:26 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A3BA646.000/4glcQG29Byz57HS0

> [Severity: High]
> Does mmu_split_huge_pages() fail to split overlapping huge pages for small
> or unaligned ranges?
> 
> Looking at mmu_split_huge_pages() in arch/riscv/kvm/mmu.c, it initializes
> the address using ALIGN():
> 
>    phys_addr_t addr = ALIGN(start, PMD_SIZE);
>
> If KVM_CLEAR_DIRTY_LOG passes an unaligned start address (e.g., clearing a
> small mask), ALIGN() rounds the start address up. This could cause addr to
> be greater than or equal to end, resulting in the while (addr < end) loop
> terminating immediately and skipping the huge page that overlaps the
> beginning of the target range. Should this use ALIGN_DOWN() instead?
Good catch. 
I'll change it to ALIGN_DOWN(start, PMD_SIZE) so that we always start
splitting from the huge page that contains start. Will fix this in the
next version.
