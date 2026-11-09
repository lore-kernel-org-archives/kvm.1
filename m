Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794254388;
	b=RvdZIF2LpPwTR4dHQjYfxpU0p5vqutoAA9GP4ua1//vNTha2jNpuxeCIcoFHeV3/tM2U
	 xdxMS7rmfw8qGyjqEbcjvUUtz2T/s8C+yDOh1dJeNzd8OEZNmXX7d95xMhTtwLhc/1BY6
	 3rNba4pFUiQS3vb7cR60YOMWMni1M0tLJ0clDXTdiW0dg4aYkRK7UiBGWUG1GZKDqzhA5
	 xWvVnIkNSzzY4Q1V8XqzGSdAFjfDH7jiYYOf4DItQHUafjGJgN5N2EBA0useeTlRQLce5
	 kbEhcPFolaunfRfY/845y2w+KkpBLSs9CD879g1kXPuApDhcCFL5/WbeA+9YjmDl+bA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794254388;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=kOt00kDVnIg1petIk2pRYb9G+8rJXwscwCWERTsP31U=;
	b=DuTbV2odGImYbcrGRbYNN9f7Kh0tCOEAwtSRPIa4BM28qLavtZUoVHUf/psxHjj0X0pv
	 VY1glQlGuG8gFMjeMeGYBH+9xPKvn3ATFij2gsBL7YJMG6XmAnpsJ5URQAZRl3aSpFVOp
	 G24pRA3PHTrBo9dnLK9qISWdzKN2mIrZawB9Yai36SQSe1r7JRC/UNXhl+t8GIy4wTw16
	 t3vgvixzS549D1jUq4fs5WR+KVeRygEXbO6pmdlPe5iZ22VL/PDy2svChi3XiSgh7eaAY
	 7XgUr5JUvqAyIAiF9ldDB71h6RQ3D8n+hfq3zNs1vwQnSoAeYyOSQ4kOrANaim4e3gg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZJxKK6JE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.47
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC7E606A321
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 19:59:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBC7E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZJxKK6JE
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-91c6ce60697so15742026d6.3
        for <kvm@vger.kernel.org>; Mon, 09 Nov 2026 11:59:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794254387; cv=none;
        d=google.com; s=arc-20260327;
        b=NhM7RO+ehfTlwOfZxcl/rWZV52ho0hbe/3fDDSCAf+BpG3KlXilQ5r0SaZZh9+6eXF
         zwKI3egjzr4sZYzNVmA1u9YMEN4kYK7OSScD0YkzS8Wl2mQ2R7lu0ToHS8azNb47IZfS
         WZJZJx0buIqPnYgWnKMXgud/77aTrGzHj+L47QH7edQvlT2K4zMXa+4IxYDq2vcUKzNe
         bttVieVystjgWag9OLUP38BsDt1W01N9XttpUU1jYH56zolkPTu3zu7V33B9RgP2D0qg
         nNtX29JUvdMAZealMjx5wKA7AsxmwFGYJCZBhil7/AilQpyTKZWUAUjNvo0rF1kfMCeh
         z0Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=kOt00kDVnIg1petIk2pRYb9G+8rJXwscwCWERTsP31U=;
        fh=zpXCrugx/aqxv7XBHDIokcy7LxdunTvcBzpWVQNmEG0=;
        b=IavzNFgl+vuoxfsx4w4Kabz6GTZBrFWGYusWZp8srRZJWkkebd3oEHnWzT9/6vN40Q
         hI1B4k4MA8mdJT30X/HntPSRv8DU9Igho5nQBuevZGxvBOClLdSWUZEdOuSelGgU59py
         Qj4PvzGeEcvPdzlVkN5RJWmV1XlaZQnIeAt9XJAD76ryDeoU5XFn71b7Mc7+dvKUJ8Fo
         /MoiiReQ+FKnV2zf5aGwL7lKvXjL5w9Nr4VwAefZj0Tk+sYpSFGqrHoFemc36o2kcHth
         IXILuGdPemqjU+h4pI5ZVcFybHLr7j3q8/FxRjtqgSqpsPxlx3vZ6/VefCci27S9ML68
         EFvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794254387; x=1794859187; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kOt00kDVnIg1petIk2pRYb9G+8rJXwscwCWERTsP31U=;
        b=ZJxKK6JEnpFDdDiwDL4cx7CHB+t4t2jIDCE+8esAsw6zjzpvtFUdtuy+Y9Lcpo54Dg
         OF8bXjgBr4CdLb47v1hnaqP7mSQOeJRjRIQxQrzgVVz1rZvUtIQ6BRio4B1ZQ4OvKjzi
         eSlcSsOBocNlecFaWKoFMoM1D9OltBoOMBczdFL2iW70rLVP9QHO4zQCSszv1Do/kVEy
         WzESzHncdOcrhEF/ithmaJ6CyNELwjjA/AQhEkzGHDINTyEt/nTJ2+RU7xKvItQsVYPA
         YtfRVAcUL3zB3iXQbC9y1hmIxwJ8cNhrnXpMdl9oAgNnyKbSRfIWfxAYsUzFlkneQ7nC
         mOoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794254387; x=1794859187;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kOt00kDVnIg1petIk2pRYb9G+8rJXwscwCWERTsP31U=;
        b=Yc1d4/CfuQx+ZSrVJQ/BpAx0HtJi5TpowAY+hUG4mWApSkButhLKkFFq3Qa6yGwQUE
         4w6AQMHEi9i1gkpZWW7QrYJk9oyGzLC0s5SUuYnD3Xb8iLlPivtUznTmNP+oWdhLfywM
         neEforD1zxWtEvfZqo/UdHC0Wvv+4Sb3hyvKl1G8EvROC7E0hKgqJ1WLOfyvGRYXhIea
         E28cyAL08GFZwCjcFokcz4GYotMaonlFTIoZ/2VF2fjKqC9Kwd7VIB1o12coURo3YS/X
         fmjwdQKisRTyewODsSZvaS1WDPLQs8u+myryk4OgD9b199mtJk5vFLofT1qY7dQr+d3Y
         eE7g==
X-Forwarded-Encrypted: i=1; AL+hErHGSoMv6oNO0Ls7STwhgtbElX9xDJJLmk7aNYRHS0JLyXrFboo6TGiEOaUUGE8sOnBwJAs=@vger.kernel.org
X-Gm-Message-State: APuU4Z8sQ8T5W3kNeszmRti1Ev/zK47mWnBCOXJMmmODrdPj+InQ96bG
	J5PMbIZZcU3f+HR1l5p5Iq6Z7qLFFXF3OK3D2Bg3ejLs2o9KIUfb7hg9yufQMf6xmawzCKPHdRw
	7WMoHv8NpSVuevl9bVKqWrlgK5Lu34UdzJI8Vqav4
X-Gm-Gg: AYBFou3s7CGIwk512eX+9/BWxhJJwUjmOSJUGcOncgVJbFzknjQWRCOrXkJT+xmaDIy
	XdnrI1E+YXUvN3TVr2kapBXXPTuhgQ2DwTvHNk6/Bnv9PHX+u9lwvTAOkftaJcZeZiaS8SQlmtE
	MyE2QRrRAKkFyVwf4xor+UE9Jn356zbWToH/jUHU0Juqjsi73IPqATdaitnHIuPF9iDeSy+TfHG
	wV4aHG3iO58c+YGEKx5UuRisJtSS6X1tCKOcZ/DpZf78LqnxYi6azHRUUcFXbUt1/4NOfR1JbSq
	6xgycEXAfxwHs0LzNI9ePQ4SmnL1gs03VuU9AwqC+IGyNx11jIOH1ys1TaNKmSslutdWzCC4Czl
	uJtLAs1gCx4WZQ0X8ErwWZzU/rTkNMkeBi660GFobJYUTrOeXPhGV2e7kjF1KxT0caRChDkCWXo
	9ivELH3oG5doEHF+xDb+QIlAs=
X-Received: by 2002:ad4:574d:0:b0:91e:a16d:7a30 with SMTP id
 6a1803df08f44-91eef808c9emr12577566d6.21.1794254386073; Mon, 09 Nov 2026
 11:59:46 -0800 (PST)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 9 Nov 2026 11:59:44 -0800
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20261105-tdx-selftests-v16-12-2024e8fa517a@google.com>
References: <20261105-tdx-selftests-v16-0-2024e8fa517a@google.com> <20261105-tdx-selftests-v16-12-2024e8fa517a@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Mon, 9 Nov 2026 11:59:44 -0800
X-Gm-Features: AclHuK90wR_z4yVrzO4MfdjN_1RfU4RbtNS-E8SukabdQfjTq985Vre6DirfMaI
Message-ID: <CAEvNRgEkS=aNPcWn3NPRL56ibPvFS1d12Rvbx6gCE-yonVgLXw@mail.gmail.com>
Subject: Re: [PATCH v16 12/20] KVM: selftests: Call KVM_TDX_INIT_VCPU when
 creating a new TDX vcpu
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
> TDX VMs need to issue the KVM_TDX_INIT_VCPU ioctl for each vcpu after
> vcpu creation.
>
> KVM_TDX_INIT_VCPU has a strict prerequisite for the CPUID state. To
> satisfy this requirement, call KVM_TDX_GET_CPUID and KVM_SET_CPUID2 to
> pull the CPUID configuration from the TDCS and commit it into KVM,
> allowing KVM_TDX_INIT_VCPU to succeed.
>
> Additionally, unlike tdx_vm_ioctl(), tdx_vcpu_ioctl() doesn't check
> hw_error. KVM's vCPU-scoped TDX ioctl handlers don't propagate SEAMCALL
> errors into hw_error: the error is handled in the kernel and only an
> errno is returned. Checking the ioctl's return value and errno is
> therefore sufficient.
>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> Signed-off-by: Lisa Wang <wyihan@google.com>
>
> [...snip...]
>

Reviewed-by: Ackerley Tng <ackerleytng@google.com>
