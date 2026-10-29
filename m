Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793293247;
	b=EJmFwDmZvhO8nC5kSnyyDKaJam2yxutsFW5bPW9v11Pp45SyXmZx6oaaxJcIrTu22mY/
	 yg2POUZPCsT8HGPr8VSPqbt1X4Ktl6On+G6f9xZMcrRui/aZKKCMhOmzrQRAuIorWrpfj
	 FVduadJ73h/mGzSX2QvKbTgTBst0PVXfbGJSZWY7qXnEzpHKRfk8PMA3bPeCnlG1xWXuD
	 uikeqfLKknA+YOGYLMnANJH6bgWT2HOGrXPyyZx+Q/zTjl/LrD0inu4U6TjviSEg0HbJ5
	 fCIWuG21InwtPCuSjcNa7xa5A9MxCq/E+RRvQXzjUDWnkYRgnh0OqjkivBgegedl7mA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793293247;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=ZD/qDGi1O6nHsAaexh1x5wdETQZTzQoYlRWPgZIsXpY=;
	b=MLDzm7ceZ1xMnMngnluOmZ7hCiB90iyg0LPKHqjYitzeKBluaREtvl159p/6tcLD1+pI
	 C3XfN7KF4cdLXCNVHNOzRqVadYdVdR+Ap9u9j261YMwiPSDXFrxd4QT38/D3PAaKEe5ty
	 ZoCeyw6WwHjBtamOOfA7nhmVKcu/SsziBb37uc0g7p5oKAXS9vICZWVJsHlbzYls/90em
	 zLDvZn0MZezxeacEao1doCmP/UkiTjVCc/PA25hDFCGPPr+uwEj5Wy4Uh/RQtP/XA8tCG
	 cMLq73mActPNqB0qtjqaxuvsmLCNebckxDCUFN7STg4Kz4/3tUdDlUnnhbL8IO2SgKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b="P/ryviEr";
	arc=none smtp.remote-ip=209.85.219.42
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D650606A322
	for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 17:00:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D650606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=P/ryviEr
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-91c75267b0fso26709626d6.3
        for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 10:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793293246; x=1793898046; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZD/qDGi1O6nHsAaexh1x5wdETQZTzQoYlRWPgZIsXpY=;
        b=P/ryviErdiPh42kReFxkMw1q1mH9fz9TsFFVhDr7/C5Fa2PSoxZUA9NuSEwkEuOkDH
         fNZeVoONCuCJO6q9+z+VTVZWbo0t4PQAZZQbmnCCao5RytIfbF7qM4u0UGfrh8SXqE5C
         1Oy++8U8wu01GKb+uUKj/3+Vr18qQiyVTGVonel5fUq452tyDa7V3ank6XovkMgPdMz1
         b4mfXcw4lUP07SJ9XOoL+xDmONdFYgfmQzR+4w8bOdy6pmffsNZIdJApXGGJQO3JrUXL
         yXzp8LM+iVAhhqSPhoFCJc5loCUVs6wj2cMaSUauBqxFa4vtTkEvYVcrRZ93WpEPiEEE
         wK4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793293246; x=1793898046;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZD/qDGi1O6nHsAaexh1x5wdETQZTzQoYlRWPgZIsXpY=;
        b=CfACEL1MJ6vP8Bx+OvfjEDmPEo/CLWbsy8qWYb4HmkXPKOqfK2PwcHuy4Kd3E3QiLz
         uDY1HuVG2dRewWZKSop6+zvzNkUBg7nZwWiDAqPlvTVnXIapEfkk46IJp5R/h2NxGk79
         X1m4kwfK6u+Glor8fkuARr+qAI4mRS2JdL3NFREpR958NLZZQfQOVl+5wPgUTMsNbcUA
         G8V+Omvv85ThgF19UpQ45YvCukJZsIH/lCH0FxDklz6vv/T7D9Q5e4fKy5enMdwzFKqB
         6tbZazE4opIUJNEpqvPbuvphsw0xfn7phfsD6ddDF1HrzdwgWf8mUw/IMnV/S3JlAgbQ
         b6dg==
X-Forwarded-Encrypted: i=1; AKwUvBxL3QOed2mVOW+K8//+/g9aV52FIhOvl2JBIljiUMdfTzndozeUrRoXAbvscblwr+dwAsY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLWeIXw4uRfkzyyyL8Z7sEGQyha7lNw7OahtQB5onr2nCKo4DC3
	5gikMTmpNCUOyNtkeENzQ2ybzqkRmVCIyxSdthpFBFQyy0f1BU9p0vzdlIuYmFlio9o=
X-Gm-Gg: AYBFou0FmuGIq29LwYVPpusWneVu63C5bwujQUw1Ej4CRu8dRC/9/2K1U7RXfJbUI++
	wjbkkncYJusu8yVjsvbQcerWOAxGoqf4IRU2KRHGhpioBuR6UXRPDytNElBVaC2exlDplMV2/k9
	QkElRKkeLefSoktNrnrZDlCG6/hOQz950p3qx4dknWrahlUaMRv2POfRvrxWC3iUvuZoVmEvHSF
	GfLfJpi0TqrKlPiscrjZPHsMcaIeWX4Gl0jurdtGxkjC+DRslR2A5fIXtzz3GA5dS6k+tCnQ2IQ
	vU3AvFOX17aPGpU3l1lpBsEI4/g06VMNJ70JcrtTRt7khS41DOTLKZxoX4pBV4Yld6JtOYU6Q0U
	gl0CAy1stkeBGGQHo/0kRuVmWWvdiXRvqZBbU2YFZckVB8O4wibahaW7CUnON/TfCSK9mUFb9fX
	Sa7P0YB4mFXpWLErdZ7ItD6XiweL1pXSy1mXLdLY1APQRZZCGEkz8CUYi5gmgw71J8a0kJurbYL
	SPFbgNoy5lE6Lxu1jg54LNbLhZNDJ9QeXsZDpHugJz8JdeDxIWA+ENG3tRw7Vqz0qSeRslL8CnA
	3txcNZ/G3YjM1soMISrS5SoZzCeowIrMGnXnLE4rkH4Uu6CDlXb/OoxyPh6xrfD/5pIY8F2S3hy
	91sDCQg5pp5w=
X-Received: by 2002:a05:6214:3a87:b0:91c:6e6a:f1ad with SMTP id 6a1803df08f44-91c7cb836c2mr100048286d6.0.1793293245829;
        Thu, 29 Oct 2026 10:00:45 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca317a421sm870346d6.44.2026.10.29.10.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 10:00:45 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xMTUa-0000000G37w-2g1i;
	Thu, 29 Oct 2026 14:00:44 -0300
Date: Thu, 29 Oct 2026 14:00:44 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: alex@shazbot.org, pbonzini@redhat.com, seanjc@google.com,
	bhelgaas@google.com, jjohnson@kernel.org, johannes@sipsolutions.net,
	mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
	robh@kernel.org, vkuznets@redhat.com, kevin.tian@intel.com,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org,
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
	ath12k@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/8] ath11k: use KVM MSI domain for VM passthrough
Message-ID: <20261029170044.GR1685504@ziepe.ca>
References: <20261029163713.1366077-1-jtornosm@redhat.com>
 <20261029163713.1366077-6-jtornosm@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029163713.1366077-6-jtornosm@redhat.com>

On Thu, Oct 29, 2026 at 05:37:10PM +0100, Jose Ignacio Tornos Martinez wrote:
> @@ -855,6 +858,13 @@ static int ath11k_pci_power_up(struct ath11k_base *ab)
>  
>  	ath11k_pci_msi_enable(ab_pci);
>  
> +#if IS_ENABLED(CONFIG_PCI_KVM_MSI_DOMAIN)
> +	if (kvm_pci_msi_wait_ready(ab_pci->pdev, 500) > 0)
> +		kvm_pci_msi_get_address(ab_pci->pdev, &ab->pci.msi.addr_lo,
> +					&ab->pci.msi.addr_hi,
> +					&ab->pci.msi.ep_base_data);
> +#endif

This connection should be done through ACPI somehow, and I think
Thomas would expect this to be modeled on the platform msi domain,
just ported to PCI instead of this.

Jason
