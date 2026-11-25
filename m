Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795606189;
	b=xZ4XBep0gTDB7zXvDGaG98HEzEYAIdL5z/sZbsIrJl/Yi7plypVleM4ekbBSuZu+pqHQ
	 KGU0V3mdN1RR1bLfBG1E1gFdfQOeNZk+U0FbSYAGl/OYfg3W5Wn9I15gB1OBDdlGVR/I0
	 or8i6TQ+28Q95884NTAzNUfnlHk5KFabibAItofYGHCSPzez/EuOTvPZmPYmt/PTHSYpL
	 vslLcGLN9f1SXysiGbDsJivwrXIf4rVDaINXx81/uKSJcI70Xb1TtoBlZ7YnwPCpMHXJr
	 Pifx6ZdWhZy4ymnr/ycOSmgGQu36QdwecQxR9vqqkthgvSnQ1D3cwLyLUvdwwVEXTnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795606189;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=PLhpJz27100xJ4lBejKqYddNXOJStc6+fMGHCxhwep8=;
	b=REam4SLe3w1RN5Zkc3UBquTvecquf+CqCft7pBkz8Bi7Fy8eP2azES3TA4KaKq3qabft
	 0OKk34SGXKXXovc3+GCAAkSfW6/hsuJxcVTv/L60cPvp/Lcs81lEhXT7noX7ozJsqqNQc
	 gOF5YAinxnyn+kOtc87c30JKUAT5AmrEuWxZ/VWi4/o9q+w5Wmur239/mfFiKZ0XiZMec
	 E0Kt48KIGb4sQy9pQ3bqvTNXrXK1HYVY7Ma+7+tpED87E34BpvxC/10ghb5UwK4w818Ej
	 oivbmRBqtzezqLXYCqy6kjmuV++M6rvVjGTwNIdbcpHZrVvWoHHOKGFnKQVm+qY8kow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AvqvoOFb;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E2D606A31E
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 11:29:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19E2D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AvqvoOFb
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48dfc0421d9so5269944f8f.1
        for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 03:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795606187; x=1796210987; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PLhpJz27100xJ4lBejKqYddNXOJStc6+fMGHCxhwep8=;
        b=AvqvoOFb5bKfd0v9Wey62hwRcyJDQZV0XkAiBQArJDmtxZ/oKC7bzDyzZruGY1BKQl
         ZCTBxwkMCDUzy5mEnTk7H1yS3GQLT4jqCUU541hP/JmsUry+nTuCJLRazVr/7jryR5Ge
         bJvImnPA6lZlT+i8sCsYn4153Fvri6EJ2oNwIVSU2t6IsXW73p45PaEVqor3hxWKmN6K
         S+Qkf4wrjK13kFIa5Q3Z7ycEkFt5eF3G86YI1qvA8jXJS/U3SBU55LCi/tStE++YS/C3
         dYKMo5eSYXDHKjKgaJT8Ik84mZOUhn5kiK9Ir515BoVdE5P/SJuRsG9aSIJQN0Dr0WqK
         aRQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795606187; x=1796210987;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PLhpJz27100xJ4lBejKqYddNXOJStc6+fMGHCxhwep8=;
        b=IJ6/dI9/HdxO+uRCpZyQ9d7xNeNEJPaaBXT+RI7KQL+feFcLeHcLknLB2kKJyJFBf1
         pjbomj4/9Me6C1Ch6RK2cRCggVs033XXIUIGfFNfhxuoSDysrnJ8A0kS1EHvWW3pu0Hn
         lWo/sOgwhPX60JgSUkbQwWAfJf1fvFXiUynNlu70s2nScmQWpZhRGhHEnDknNCpKRiM0
         BAUPu71UF5PTIRFIUDZVUrXiCBBVHJoIwqCt94xEhE48gYRbg8zv6wKnnAC8/Bw8higZ
         JzCSs3GPpohFbE1fIJ7JPLRIDGHAD3OMWcYmSMqqgVO4MwCVru+p7QWusw4MURtB+KSJ
         CrHA==
X-Forwarded-Encrypted: i=1; AL+hErESXuUNpwAZLgUW3XmgXTZql2dDZDfAokVW5vXHvTQQ5J2UKvcQDqEXI9zIfiOG9nr4rF0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+K3DSBeiQliZGKEWvTQfPJ/vb1f6cZ6g8Dwai4t0mA+ejyBl5N
	to7BxzXMJW5r/uE/wgocVq+UaVSmPkF1BzLa1vRJtmzXZfF1gCTNt/Qg
X-Gm-Gg: AZFdTZe+26BaaNleK6XDfwxvYKvqOuD9n6A+qY8/LScH88ZYNNfvneM2BBnyxSLhg9K
	w2k/ZDlumkgd9nAoi9WcEO1XaheqzyRSEcu+b5edbnKw0EVB/CjREvTEw/KAuCQU3GhByvelj+C
	7f5bZ46zttF49CdmVUmU6ObUPX9ILl44vMwCU7N0/EDxoKbVWNj7hoTPgv3/AP/lUmZcBZrOPI3
	XueyDIcOYoNu75CeoeyzKim9M2w0IiJ4Vrdjf0lDg36JOlaK1T3xoALDCaVohPdx2wOu7iPvrTE
	VvC9PbdrMH0NjfBfQO8nGOJG4fO7epHg2BMNXhGhmdbDsdmw9NzHg/cajw3IGwdjImA8bIBCv9a
	9f/1yoHfrgYB9Ym0ggZvzHRgRDuS3ewO2nachZjBWlBX7POujPjL5tEAgPLfz+FY06h3A2NCL/0
	pp9TOkuOieWMxJYrfp1pRFcrRQwplf8Z6kN7lFUKetntXsbNBTCTWH4YePtfXKIKeXliw3SUZQp
	8ZDYRKPkVOMrEGCAAkJB2eW7RzCsB4euUflVWSmxDN8+ZIEB25cSsKVe1IHyLKFsIGg2FnHkB3C
	7x7BGy+E2a6FvRY5FG65Ebw4uvnQnYTiQ7k=
X-Received: by 2002:a5d:5d0e:0:b0:48d:f831:2681 with SMTP id ffacd0b85a97d-4abb7d465a9mr37285629f8f.38.1795606187286;
        Wed, 25 Nov 2026 03:29:47 -0800 (PST)
Received: from [10.45.18.224] ([15.248.2.8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b110c3csm32638215f8f.36.2026.11.25.03.29.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 03:29:46 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <fbc930a2-7f5b-4b28-b678-e10b97fae2cd@xen.org>
Date: Wed, 25 Nov 2026 11:29:45 +0000
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
Subject: Re: [PATCH v1 16/21] hw/9pfs/xen-9p-backend: Validate
 frontend-supplied connect parameters
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, Hui Peng <benquike@gmail.com>,
 Mark Syms <mark.syms@citrix.com>, Feifan Qian <bea1e@proton.me>,
 David Woodhouse <dwmw@amazon.co.uk>
References: <20261124232247.23169-1-dwmw2@infradead.org>
 <20261124232247.23169-17-dwmw2@infradead.org>
Content-Language: en-US
In-Reply-To: <20261124232247.23169-17-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/11/2026 16:22, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> The ring order is read from the guest-shared interface page into a
> signed int, so a large value became negative and bypassed the
> MAX_RING_ORDER check, leading to an undefined shift. Keep it unsigned.
> Treat any negative return from the event channel bind as failure, not
> just -1, and fail the connect if the frontend provides no 'tag' key
> rather than passing NULL into the fsdev layer.
> 
> Fixes: b37eeb020123 ("xen/9pfs: introduce Xen 9pfs backend")
> Reported-by: Hui Peng <benquike@gmail.com>
> Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4523
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   hw/9pfs/xen-9p-backend.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 

Reviewed-by: Paul Durrant <paul@xen.org>
