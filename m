Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794253214;
	b=T0U/D8HP52yQPD9ISFOBFAT8eY9hGfSKb5eDOxz8k7bav8S4pXdHdjEidTLOIDE4LY+j
	 DQZfs1yp8clZQ+kYwoKVunK4oq7YSx/2vG/6iNNpNAf+EsEr7JC5pO0ghOhMqxquM2HoS
	 Acy7qbs2KJbdx6BKE1AtWfoz2Dx/qsenZ1BQLKvZmlsb0XMp4y/RVvwTR2gnpVWHTr1yf
	 BXyAbRCidBTJefNeq8JbO/SXbJOTqfUTENIY7OTInCOrr2nXYobR4bxYyZqu3MA5wN51L
	 bjSx8p8aLtkEDwKKFcQDLfNqY+9sajNVYA8ifxJAfk42xLcHMbfmVWQIJuU0JfCxhHQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253214;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=UTqecpq4mCjlHgsqGbaWqa8tI9zFEKPt/FYnQB8tTfI=;
	b=2B+PgFI4DN2mmzqX22dLYnRzxQt59/pyrMBRtzv9NEsf7c2MrMyYnWFiK4+pDvC1D+Pq
	 IobzhpTSSxai85Xbo7E473ReLXqqfWwU1O8Mg7W9PI5YiqGnMP7ZL6GIKyYvB7VZt/m2v
	 DmgKRBilwvbUPny4ytewXi7auYgXP2kzJTb2DB6uuboSTwSVXGxxBQHWsRcCy8cmwTfD1
	 0+X5FlQXBUQphHv+GCNIun+C3qhByHCELoulq8UZs/NnlCpuQnlm11+weMjH/tWXfvsvi
	 5FjsMkEIQd6ihCuZ4vZ1a03Jua8urSEYko37xhUZe2CC5d2i0S0K620/tGB2cyzX1Xg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OZgOtFqT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.45
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AF7606A338
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 19:40:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8AF7606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OZgOtFqT
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-91ccfb88e4dso16209156d6.0
        for <kvm@vger.kernel.org>; Mon, 09 Nov 2026 11:40:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794253213; cv=none;
        d=google.com; s=arc-20260327;
        b=BcMGpOlWkXBYPmRG0+Y3VkJoFe8AR1yxDcbE/aRQodRVqapKzYM2p2pzS5dq9jdZqT
         inRKRpeIQP4I7/PlrR/csss8bQsBGlmVI12t53eiRERYCOIYSe2gZa4YH3MY10qcCCGs
         mIAZmpvYORnMUlME9ouQXZfagbfo0BAm98exSoJSNmeEFZ+NXJrTHFTKSgFSjjiZfy8Q
         H+BPGoPDD14Wa2nwtMvvgNPIZ3+y09A5ylDzyj0d7ncIXeWEHUR+ZToDOfi6+AJJY+6Y
         gbEm3tsDzhfCC7cwBGGC3y66Ki1cuu9z9Ceg1C+wjZXbKADjP6rZiG9KspME6FhfuZhx
         pfcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=UTqecpq4mCjlHgsqGbaWqa8tI9zFEKPt/FYnQB8tTfI=;
        fh=M+sfabL2Kb7jR3ronTKWgFqlX32ufZBVV+a78taEinc=;
        b=O/LAdzxOwNi5gOQ46hphA6BlrNCH0k+sPfdubhK2lvDdQDwymlJhLrHXhMfJIT/FFv
         gFp8HCpGWzULzw+mmumafUuvLLTAtnN3FOiLrWN8ngbGq2PZa9g5d+nUT0pUMYc9BOY4
         VGwqeN5v5Lij5HHw27CMtz5f8G2DphH6X64rxfZh+RUm395NNHOUhXCKYeuTdBFNvHaI
         RZyK74pEKhRrmWEssXOPl5HG096zDI3n3M0IO6oSHBw8+fVkyZwzBF9N+t8vk/hJ3X+j
         NllYhzIMkhHkF4qUGpPgACz6Jg7DhAnCh+NBARg+tR09Icf3D+wmEjSujt5hLD8okOc+
         j+Tw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794253213; x=1794858013; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UTqecpq4mCjlHgsqGbaWqa8tI9zFEKPt/FYnQB8tTfI=;
        b=OZgOtFqTTqmNU6HzUDZ04a/TGSA38D4fixpZoEEPnUj4KhhafT25CiiDv9VDIn0ImT
         0cDtb7mJ40WUX02kyX3M9uTJYK/hWi+KE+AQxYnEPKSELhMlAFsEfyVg982+N37Ogsil
         5TWhUdm1q0b/x4tVdvupVgshnkw9azWKDnI0XbEnPcWSTqLHILPj6otmwaGVgynJrY4F
         CZbiG5Ae6S89hHcC0i13A5tRNpDtLxLKlLrWkC7eDJLbij7XpUM7kfbtZ1eHulY008fD
         hmShvcVU9R/KWfN/IdSRoCw0oGMBP0uhvZPA1AmxzWcM0ymFk+8WSS0Le3ZigH04eTQ9
         +RWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794253213; x=1794858013;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UTqecpq4mCjlHgsqGbaWqa8tI9zFEKPt/FYnQB8tTfI=;
        b=l6/aOGhyhozsyi8Q7RO1Sa3qUPRsueVY/ZSUGKrBR0BkeLUXt5YAdIdC3Sw2uuuZO0
         F1DUMTjGCzWTjWIs2RnTOQjQZVTJ/KNpJfICNAjBrhp0ljToCSJYqA3uLUX18SjAYsX/
         ebcwG9k8iw4rpTfcJqig03vknYqH3Ak7+hgo6czs/HVx/6ryh4U1HeTXbAsUK4Cg/QSm
         ihVSvV0AWe3hj1Bmsy98+dqkbKkybvhrAHdK4Wj4P4hFLwMAM9Mi35yify8u8m42aCBD
         umjS1VaEEIMsnkuPAZI5UCOEJ+WkHl7Hbu0hdv5R4+yr8AwEquyOVg4cEB4bpG2XIpz1
         3ZwA==
X-Forwarded-Encrypted: i=1; AL+hErGth4TpXtmQjJvCp1k6ulietpi5YQ2enxrxc8e+nBmfHdBrHNksFKg4K62KaRuQX7WSehw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8pDl9voG9SbFZS9avCNjGuq0mQ8+MNxBSKqEhSQBXWVrf22mnm
	xEyzJUg8ZnJT6ir7DqQoqSuRqE4grFSNbshUG8AuLmWPwk2RPyfhfSjqCNf5TwPGIBO8kxc2ZVW
	tgzrY117dZnecqRsOkRoThE/EJdWJv72BvTZyr2Rp
X-Gm-Gg: AYBFou2/65OaC7yAETec56boGtTKyCPFuLeVEjIUwV9NiTJjsWyYOfT5EQyT6gNOb4e
	gjzgagE36XTJm9D1CfZH1hWjLa6+3xHtDg5sCSbcJ0mLz0doRGczyBydEsc+N/OUni2Eaj6cm0n
	R4pPZhB1kCzXIrepyfuoYkTvoL8KM1Eyz/iWTySRP5ymhFkfC/YLCs+TNyRrM6+sjDyKdXU30PB
	DRSPhCnHwA2NDUkKpvtQOrOrvJOGLQRFl3lHGXf0CmEQEpK9gE+Uw7AU/F9jRyLZurybB+n0XhO
	okKtfNOcJdV//UBwy9gYio6+CqZ7aTLBElr1APJzJrC0Bb7VcdfEQ1PlGbCc+UHnIZqtDpRR1JX
	8hKrOEq+EoGwDH91/CXUYLsvHpuX2P0EiAS224h+kqkpF3k3hjy10UGNzLUNN0vj31flfCWeK9R
	PltycoIjuYIzgd/eXmJtY4VBY=
X-Received: by 2002:a05:6214:1d2f:b0:91e:9437:95a6 with SMTP id
 6a1803df08f44-91eef866f62mr11481566d6.47.1794253211943; Mon, 09 Nov 2026
 11:40:11 -0800 (PST)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 9 Nov 2026 11:40:11 -0800
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20261105-tdx-selftests-v16-8-2024e8fa517a@google.com>
References: <20261105-tdx-selftests-v16-0-2024e8fa517a@google.com> <20261105-tdx-selftests-v16-8-2024e8fa517a@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Mon, 9 Nov 2026 11:40:11 -0800
X-Gm-Features: AclHuK_q6pntXPEETCsk4rrzlvTAf21VT6IGAyCXiwifcwkt004hhyyHMGQSvVw
Message-ID: <CAEvNRgGL7B_5q3N0Jc1dtSj=J+ywOXaSBDx+x9OWn5odMKN5Eg@mail.gmail.com>
Subject: Re: [PATCH v16 08/20] KVM: selftests: Expose functions to get default
 sregs values
To: Lisa Wang <wyihan@google.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Ira Weiny <iweiny@kernel.org>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Kiryl Shutsemau <kas@kernel.org>, 
	linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Roger Wang <runanwang@google.com>, 
	Ryan Afranji <afranji@google.com>, Sagi Shahar <sagis@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Oliver Upton <oupton@kernel.org>
Cc: Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Lisa Wang <wyihan@google.com> writes:

> From: Sagi Shahar <sagis@google.com>
>
> TDX can't set sregs values directly using KVM_SET_SREGS. Expose the
> default values of certain sregs used by TDX VMs so they can be set
> manually.
>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> Signed-off-by: Lisa Wang <wyihan@google.com>
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

Reviewed-by: Ackerley Tng <ackerleytng@google.com>

> ---
>
> [...snip...]
>
