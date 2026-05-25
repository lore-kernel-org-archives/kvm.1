Received: from flow-b8-smtp.messagingengine.com (flow-b8-smtp.messagingengine.com [202.12.124.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C08B3F164A;
	Mon, 25 May 2026 15:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779723807; cv=none; b=B+Hi/1CZvsm9wS9igKQUmAD6jRz+JJoPhWE1DlIS7ssr+X0lcsnrrSVdgSTuxyOoRd/R1sSxOoapMtlGMOxPJrFgA+cpBAbWxmNxYMN6MHWDWLVpkIrkY8EQH5qatFEKYQtpuqV/sWAPNdSF5Ftr0LnWJvcOriQRMzOgsGs2fZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779723807; c=relaxed/simple;
	bh=+hS2HN6YJ9VAQ7+Ng1UB2i57HLuWml/ZMlX5ObpwjyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVBehEO/Q0xgADC7ILp/bzANyL7rySFJ5MM6HZYlxBpL3ISksAjt18Gj+Qe15SvN9ggnPu1XJlCh0WWzxVc04SOxw2NKRZHM5AOGKHbi/Ni/HkMwth9cczlnYNsS4F+4OrU4TRSM0MbuGNAgjBLkuEWEbIbz+3wTrXKOzhBYez0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=kxdTxxZK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bohjmZYO; arc=none smtp.client-ip=202.12.124.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="kxdTxxZK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bohjmZYO"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id D1AB5130096F;
	Mon, 25 May 2026 11:43:24 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 25 May 2026 11:43:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1779723804; x=1779731004; bh=88Nud1y/YibNrOB0gSUwBPRtOkXj2T+J
	62GpPbYHumI=; b=kxdTxxZKNlyYEJaEjhzIlxV333uuHLj9CP4dASUuDqRAqbuJ
	aJKq8l6iZqZcYxYLI/khLFcAP7jxQHszUuoYEIDLJp6RVnYnpukWOl/mACh0njF3
	izlfzrGG1M0snv9Avqx3GCfuneMMOtmDX5tFY+r0wo9UJDWS1k75UUv1pWnxzZ1j
	X3QequtZaImnR/rW6htjHovgC5a/kpvor97SCuducSKyfRtSiI54sigsnKaPYbf0
	J3fSwf+P2Fo+vfV0vn+Am4xjyEqWPkKWin8VyBpJwsDWSB6B0z13ecc0eF4tSL/i
	lCoO+ZnuPE/1T9Kxg2LBba42AAKNKD81CP/Q7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779723804; x=
	1779731004; bh=88Nud1y/YibNrOB0gSUwBPRtOkXj2T+J62GpPbYHumI=; b=b
	ohjmZYOVb8Dbt/nAmgSjrg6JAJpecC91nyLAbriwhpE5fNp+s6uJXIH/e34R07bz
	qABASIsnFTkG5Xwsyuqoz/luOvvKSdnESLmEi7Fb8AcPnx4QJo7AhFISgNixunbV
	DdjYFiimoKH0C8d/cjNxVg06CBKxZPHAPmu35yRI7ZvQvBni09i+EYv+KvtxhgAV
	eLmQ4yi/dGS+4OgGUBSq2PO3CzlL1vAFmjJqTbTUBR8DUSH7vD7r1WbCRBo0PbAm
	Hes37uye5BNiFmJb8AeSrohmjHDpP3w1w7YAnAzwjUtHJxHh1BEpmkxijslqHlB/
	csMTM21XfaF/kxTOXc7ZA==
X-ME-Sender: <xms:HG4UakRvkJgOWbODwyYK3Dd9p9S5pJRxlHQD6tL5ZwqbhcasRDr-XA>
    <xme:HG4Uaru9XeWfkc1jBBcQMW-5J3LdGyHmwo4EGg21kgsmwiwGu0sOi8-Q0PxRsHpnQ
    R6BN1f0k2caSb_q3ypL7LzhzfOK183Nzfylk3E3oGe6n2npk7jDAq8>
X-ME-Received: <xmr:HG4UajvUogtrdRx4c4zHT6RO4dkTRtgRQ8HnJIVPWdhaKuq-T7FLhGKcy-tzYQ>
X-ME-Proxy-Cause: dmFkZTGEPse4hV1yBwsDDEa7O6Lryon99uUXj/XLpI0tprakm/YTBddT7aRX8pCTW2DPLE
    wxqIym+YUtlhKLJDWeGlCptVUlFMjgS9D7yuWlBIwCAwtYKi6zo0j4CAVYn/vgyZJPXLOG
    BYtH9Nh6HPuNoLdp1/VdWgbOADAvtxmistcJnr4qLuoaufELcanxBkRVcKH65VViIUzn34
    Kp2QKpFHEZKdG/bhngq9fPozMAPTXZBBmDnTHHXvVQgDsw5EQro4ZLXcqB86Oyr85j+lYE
    v7bqRum/AgTZ/4ycaOAngfI42jEaiRD9E5AlmyGSKpkOU4sWKlAkCcvM1cGoh+03YQwAY8
    X9aQ1CIpVnLo3jflOe17bGQnRrxaoDobvUAKBnTzfWMmK1Ps8kX5fFimm2/1yY9k153gDe
    0gVknUi+LyLfDIOhAsTGivf8ANnZQ+iv5gVIQSdF81jTeFCwUCwsU8gCs5KEUc8yWpm7nf
    9m2+Z3W/bH9zYhrJzBs4Xc0UrEMn8ULjNTnMtxrXNt3Y5TRdc4jQxK7EBfKOoGmhysKzrV
    N2+QIqxlriwwcjeCt30SI9i8qmYFvFLB9Xf7GwwlKXD/f3rl83QxDO0z8RoyRJYz2Yr1oA
    M6Z4BMDhTarpoc0aPlljBl6npKQx/IAG2YN6iEl/6bJhwg8Usffad3Bc+lgg
X-ME-Proxy: <xmx:HG4UajfebOWqTwI3QYTwwOd16SRNaJkd3Lld7d6QpmbSdW-PRFsSYg>
    <xmx:HG4Uam7nD7XuK2hhgmZfcDob--JLud8cy65K5QCCMu1t7QRiJQpTaQ>
    <xmx:HG4UaklFqY1dRGooxRdCzWkMortxZHcVr8udzWqIOdITllfPaiVm9g>
    <xmx:HG4UatX4Ds76lcLwxTeWTlz9ak0Wjt9Syd28k8IZklMpMJfvVl6NTw>
    <xmx:HG4UatmOHtsROuC8_xCfV0vW8C06WenfPA9EBab_FcJZMQbyxqXHCaoA>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 May 2026 11:43:23 -0400 (EDT)
Date: Mon, 25 May 2026 16:43:22 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, akpm@linux-foundation.org, rppt@kernel.org, 
	peterx@redhat.com, david@kernel.org, ljs@kernel.org, surenb@google.com, 
	vbabka@kernel.org, Liam.Howlett@oracle.com, ziy@nvidia.com, corbet@lwn.net, 
	skhan@linuxfoundation.org, seanjc@google.com, pbonzini@redhat.com, jthoughton@google.com, 
	aarcange@redhat.com, sj@kernel.org, usama.arif@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v4 13/14] selftests/mm: add userfaultfd RWP tests
Message-ID: <ahRtlPsrj31R-rek@thinkstation>
References: <20260525113737.1942478-14-kas@kernel.org>
 <20260525123904.0A31F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260525123904.0A31F1F00A3A@smtp.kernel.org>

On Mon, May 25, 2026 at 12:39:03PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Hardcoding _UFFDIO_SET_MODE in the unconditionally checked
> expected_ioctls breaks the userfaultfd selftests on older kernels.

Will be fixed in v5 -- dropped _UFFDIO_SET_MODE from expected_ioctls in
test_uffd_api(). The dedicated RWP tests already exercise the ioctl
directly and err if it's not supported, so SET_MODE coverage isn't lost.

> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260525113737.1942478-1-kas@kernel.org?part=13

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
