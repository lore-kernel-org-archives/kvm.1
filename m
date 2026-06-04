Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCF6409E07;
	Thu,  4 Jun 2026 16:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780589662; cv=none; b=Bu3nRcJ3f/GzotIp5jiUlTQycyGfX1OhQtKpF2Zwh/RqVU8+9EEmYBj04HkDB4+s2//8oF0hYVQrp8hajm+diq2HxnHz/AxUaq4YzSUTP8XRF/OfSk0xygkFBBOWD+p7y2V89KcqktBgS4Uf7epGKuodSxQyOaVP7GEOmzWaRsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780589662; c=relaxed/simple;
	bh=PAnTwGzhU7hZQJBjO9YW2fVB7bTAGggEUp7o+9uA2PM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DC0yX8y/sYD/YHsVvOJfC8wj9qYZb4awCuC9V/L2HmrlkybM2gkcPspDf7kjSTqPkLO2MgmfnvLEo4O0ysDHAkCFk7LR/nnp6cZOGS+mRDm81gcz6QBk8m9uvXYUHn48oMw/cSmzq3G3heiA3hcQL6620IjhynVfFbzGp6+G9fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fGu6qSpc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGu6qSpc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32AA01F00899;
	Thu,  4 Jun 2026 16:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780589659;
	bh=PpMgxAcmqP0/HxSDQyuooMlOZ/9hDkPU2x1Wgc+yUA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fGu6qSpcPJU7kXUfED0HTmjGhylwEox9gFldFxHQohlR+zhnG8jMaBlWKnoz0liZW
	 EOjVW9ZLlEmnSWxCkKHKlgmrnxQ+P7SNpk9QjesXs8+2GKM+uxAoreENEi8Z0e7gak
	 eAwHHLp3WuDRZZQzBKDNmmGvMsnYftj2waVmY7HYYuByi544VdolBUrSiuHGnURXk+
	 CvGae2pFtxUvs2s80ZCIsZj+0KheDy816uDx0SjW8+t3wYAZE4gRc5wBknzz45jpIO
	 cHakwZ2XjP5p/j0+wlJ5SR7vVxJZNCjrzy2I37mslpeSoNp++aTUPT8+vUokIX2Mlp
	 Ny+ei8FdNrhhg==
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id 7E4D7F40076;
	Thu,  4 Jun 2026 12:14:18 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 04 Jun 2026 12:14:18 -0400
X-ME-Sender: <xms:WqQhamkdk1Y6jvyWyC8LH9ULV0ywiz9xz9YSe_41SIZuej7E1L_Xgg>
    <xme:WqQhapgp38hR3XTiLct77z2TQcgEwq1RhYAbA0E4-DnUCg-Gd_S8CXZoh2kxLFtr7
    bzmBSdh5EDjt2zerkPdm_TkPKQ7ZZY7rMKafEB3uO3AAxQ3qfikMrA>
X-ME-Received: <xmr:WqQhaoTjvujKvwbj7wSCKiba7kDxsSPH_krjXI-Xw6x-8yZvvNqxQYA3qzK3eg>
X-ME-Proxy-Cause: dmFkZTFGEzbEvp3rMXU4iRhENjqviIxNp7V0LUVnr+Fq6cSejAtx8FcqjjaURnh943PB5m
    ACNmP1eVrpC4WKxEYFlGtsfl+sLKO/sIXhCA+l+8VyKxwjeCuqH9asWmc2xxn7AmvQ/nmS
    JLcNtzbYuAPFWssmdGRx3PIY2B5Oj4NlPjetc7p2P2RvsOvn9uiwn+s+97/2wga6vp3Phg
    qyACbjqJzuQpbEf/la0N8TltHAypJ5Terb6RIUUBdgEvR8j7GLzbUV2oBWGYM/En2oxjsU
    xMb8khgoM+1JPXiuWXrvPiAb0xeb+IrPitlygBw8YtFGH++z/ZmC5dI/QMWr/NRv4gi7RK
    yV9cXxNFhhlNF6aDjt30Z44QuXolA7Yd4qkf89w3cJioRLyZuk+1/gF7R1NfnIQtw0t69E
    62fMkjo22E35jSDnOqreuzVpJBHxBTG+VUZ49omMPV9ygsc3HtwufIl/kdz61hj2mFwwDm
    qawiqDTBbA6L0F8JUFwzOTs3oNZkLVRZWc/IYgH7PGSN6jLwY0mNQYTmF8fFw7AaTKrlL7
    4BRLiI6jh83hqW87Ubpf9KqANLzx234YnvGOCXeNMVCaMcDWLAZA75WA+TlFxyzKfLbOU1
    ACPT2g8UzLTTccfjEwnez4j3+yvF4WMcjAV7uR+3zgbxbGxLBvhYdi6ZDkUw
X-ME-Proxy: <xmx:WqQhaq1FYbygoaciEetWj1LouU5Vp7CbRdBDOP8IclzhdZpIGzCE0w>
    <xmx:WqQhai1epsazh011up9nQYHps2DaoGfTS9U0uBD98APiszB-Tfah9Q>
    <xmx:WqQhapsoHVqy9O51rKBVvMNdmJJlal5ybc2revNTlYReZiTjJON8Hg>
    <xmx:WqQhajAjWiUwnfBkiKCvjaGrdhKB0e0pDlRUX-BfBJODwSOwX5e4UQ>
    <xmx:WqQhat8pG0cEfblocA4LNIImEc2AEn7PPipWFX0ivMWSaG-LblPomndH>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jun 2026 12:14:17 -0400 (EDT)
Date: Thu, 4 Jun 2026 17:14:11 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: bp@alien8.de, dave.hansen@intel.com, hpa@zytor.com, 
	kvm@vger.kernel.org, linux-coco@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, nik.borisov@suse.com, pbonzini@redhat.com, 
	seanjc@google.com, tglx@kernel.org, vannapurve@google.com, x86@kernel.org, 
	chao.gao@intel.com, yan.y.zhao@intel.com, kai.huang@intel.com, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Binbin Wu <binbin.wu@linux.intel.com>
Subject: Re: [PATCH v6 02/11] x86/virt/tdx: Allocate page bitmap for Dynamic
 PAMT
Message-ID: <aiGi36_YpJBRechp@thinkstation>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
 <20260526023515.288829-3-rick.p.edgecombe@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526023515.288829-3-rick.p.edgecombe@intel.com>

On Mon, May 25, 2026 at 07:35:06PM -0700, Rick Edgecombe wrote:
> @@ -579,7 +591,12 @@ static __init int tdmr_set_up_pamt(struct tdmr_info *tdmr,
>  	 * Calculate the PAMT size for each TDX supported page size
>  	 * and the total PAMT size.
>  	 */
> -	tdmr->pamt_4k_size = tdmr_get_pamt_sz(tdmr, TDX_PS_4K);
> +	if (tdx_supports_dynamic_pamt(&tdx_sysinfo)) {
> +		/* With Dynamic PAMT, PAMT_4K is replaced with a bitmap */
> +		tdmr->pamt_4k_size = tdmr_get_pamt_bitmap_sz(tdmr);
> +	} else {
> +		tdmr->pamt_4k_size = tdmr_get_pamt_sz(tdmr, TDX_PS_4K);
> +	}
>  	tdmr->pamt_2m_size = tdmr_get_pamt_sz(tdmr, TDX_PS_2M);
>  	tdmr->pamt_1g_size = tdmr_get_pamt_sz(tdmr, TDX_PS_1G);
>  	tdmr_pamt_size = tdmr->pamt_4k_size + tdmr->pamt_2m_size + tdmr->pamt_1g_size;

Maybe it would more readable if we reverse the size order:

	/*
	 * Calculate the PAMT size for each TDX supported page size
	 * and the total PAMT size.
	 */
  	tdmr->pamt_1g_size = tdmr_get_pamt_sz(tdmr, TDX_PS_1G);
  	tdmr->pamt_2m_size = tdmr_get_pamt_sz(tdmr, TDX_PS_2M);

	if (tdx_supports_dynamic_pamt(&tdx_sysinfo)) {
		/* With Dynamic PAMT, PAMT_4K is replaced with a bitmap */
		tdmr->pamt_4k_size = tdmr_get_pamt_bitmap_sz(tdmr);
	} else {
		tdmr->pamt_4k_size = tdmr_get_pamt_sz(tdmr, TDX_PS_4K);
	}

  	tdmr_pamt_size = tdmr->pamt_1g_size + tdmr->pamt_2m_size + tdmr->pamt_4k_size;

It allows split it into logical blocks while keeping the comment attached.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
