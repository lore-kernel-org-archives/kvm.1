Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5977411F9E
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 09:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784797232; cv=none; b=OLaaKK3RX0rjJQcSPY09iSLBj0m4QAPHDdX+TRz025Vt6ny9DTZ36h7v0iVQ3z40NwnB1rRYL9EYfXwTbPNapeRLSkTP9tDz4HhGUDy6lx2wErV6L4wK/kM2VFJtBgEKAqAE+yB+N2ETganw28G8Evd2446M1MIMh6sLTGZbATI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784797232; c=relaxed/simple;
	bh=b+Yb+gLLuIShvdQZVzyZyQXKtf9BQGTmB9hGa4ULn/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Z+aCG6x6w3pe2gp7Wlv5geMpNr5iP/pwYBbcanBK3CZi/kBm4zuQAC2/qMrtRRoopeIagpw9XEbToDnHJm9/L67CeC++fZ9gaZ2E+nIlvIpIcm0foBhmuLJ3Z/iTEV3pJugVrurdHZGhkl9c/JB0BeF5Ae4r0zQirqUkkIKX5fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=E109zZU5; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="E109zZU5"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47c2b362ee2so321264f8f.1
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 02:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784797225; x=1785402025; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uehkej/+3IvHOknJ9E8G9NfClRJBiDQG1DcA76gXgp0=;
        b=E109zZU5y4B4Jq6YFYcjo5e+HCy79hfhzNmnPUARzeJoduT7cBy/wHlW2RniB84Y0s
         XEQ9rwXPyTVg5fuE1b0f1rt9HDpWH2AOgvepFZBzrhQdIhJsC6PZJamsEaMusxEAGNM9
         Xg7Lcolfjw/4JH1vqunYJKSdiZpeZsDv/2zgGoMxdbmMs9eCNklTto22uamVdZoRCrw2
         VxST9TMLmnWvOtfxIH08lIY3rq5CvPXrsOo/NsrjSjlpd8Ca9UC3JvgRnU3OyBCl17OK
         ksMk+5dtg/jNRagt1wcZjLWCHw8T7lMKpkd+M9aVlQOn4VyX/Movs4WMTgQCdvGvzqpg
         G/kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784797225; x=1785402025;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uehkej/+3IvHOknJ9E8G9NfClRJBiDQG1DcA76gXgp0=;
        b=bvwcVxEoBXUfOXlaPX4tTPeokFeEIsfGd3TUaV8twkkMuKAeHwGMbZutlvz037APry
         HCuQ8hZbCr+7PaHb36LjVVXXLxv7vwVmdSv9VGMpJ6Z4KPH1FoDgVNrsLrP86rvBAqwl
         iZu/fy0K0YeTiXwG6trgc9kIadqB0ZK9D5gmIu8/dUpkq7j8cfHXBD61B/h+kWx/NrPK
         fTprIEnNy2XIEtc9rFbFlZ5QNpajXvEFj4NB27oS2oflXZamNNSXHt2p4fOpnDWaOzgi
         o6vjsLZhTpaLj1Mm8CKaDmM3nbRiRJPBQRokTmw5gAW3smXfY4HuGhdFh59jELVWga96
         0MTw==
X-Forwarded-Encrypted: i=1; AHgh+RrSb38TiYGdJNz9SeCSdxxhYh/PZUIfowCTVzEE7e4eDP0tykGG9ijbG/bk6IwWc8oeuVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxASnQYKgZ3bLeDpRcZ24kRHxnsIABiB7CZRIBPjt21RHwRwhui
	7nxagPU7ibmSE9ZhdCVAZS71aGZenpYqC7gyvhNbD3ntefbdDjAnqefmdviUAVls0eU=
X-Gm-Gg: AR+sD11slFz2ZNhXuQn6pITxSN9wcklvRfDnc49WTTWejhBygVQQGp8HdvjPMyhFTPY
	FQ7fFREKpCoEfl/nmjwqVyNf6mHtoU1aAQPCGPa+RV1dlUU3Sjs4n52KH1ESQQuGVH/Z9c2HGWv
	yKF0hiOZTKRMrp4vEy+WancQc40U0HoV6gL51UOlAuTxOYUMXxB5uFmS8GOxGgVM9rh7m1nRZFu
	iAO414tsEn6cRrBdANHx/IFUfX63FQF4cv+ns8A0rK4+WdtQ9IBPLrzXL+ByhWehaca0J10skTy
	W2ZvNhFnkBr9i33XjJO/KPxObNjhkQk0HV0WqFWWbCWJW0Q6JhDR9q33TpLY03h0XSa7jBmlWFt
	LC+2buNThHoEqfGDI2Z+YlBUYA7S2CFEUoCnoP+JewN1abiySp70IkIL8Sw4ijY8b7zFewijcLx
	V3ss6XcmjnBBa1Bl0=
X-Received: by 2002:a05:6000:4203:b0:47f:7b75:61a with SMTP id ffacd0b85a97d-47f8d71f494mr2735264f8f.15.1784797225474;
        Thu, 23 Jul 2026 02:00:25 -0700 (PDT)
Received: from [10.20.4.146] ([149.62.206.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c6d277sm14123850f8f.32.2026.07.23.02.00.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2026 02:00:24 -0700 (PDT)
Message-ID: <bf248f51-afd3-48de-939f-89df65b23595@suse.com>
Date: Thu, 23 Jul 2026 12:00:21 +0300
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 11/11] x86/virt/tdx: Optimize tdx_pamt_get/put()
To: Rick Edgecombe <rick.p.edgecombe@intel.com>, bp@alien8.de,
 dave.hansen@intel.com, hpa@zytor.com, kas@kernel.org, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, mingo@redhat.com, pbonzini@redhat.com,
 seanjc@google.com, tglx@kernel.org, vannapurve@google.com, x86@kernel.org,
 chao.gao@intel.com, yan.y.zhao@intel.com, kai.huang@intel.com,
 tony.lindgren@linux.intel.com, binbin.wu@intel.com
References: <20260718014500.2231262-1-rick.p.edgecombe@intel.com>
 <20260718014500.2231262-12-rick.p.edgecombe@intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20260718014500.2231262-12-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/18/26 04:45, Rick Edgecombe wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> 
> The Dynamic PAMT get/put helpers use a global spinlock to serialize all
> refcount updates and SEAMCALL invocations. This gives correct behavior for
> concurrent callers, but leads to contention. It is especially bad from the
> KVM side, which is designed to allow faulting in EPT under a shared lock.
> With the global spinlock, not only is the lock an exclusive one, but it is
> for all TDs instead of just a single one.
> 
> But taking the global lock each time is actually unnecessary. Only the 0->1
> and 1->0 refcount transitions actually need the lock (to pair with
> SEAMCALLs that actually add and remove with the Dynamic PAMT pages). The
> common case of incrementing or decrementing a non-zero refcount can be
> done locklessly.
> 
> So create a fast and slow path. Check the refcount outside the lock and
> only take it for the slow path (0->1 and 1->0 transitions).
> 
> On the put side make the refcount adjustment and lock taking atomic so if
> a 'get' happens between them, it doesn't cause the Dynamic PAMT to be
> freed incorrectly. On the get side there is no technique for doing the
> refcount adjustment and lock atomically, so check the refcount again
> inside the lock.
> 
> AI was used under supervision to collect/apply feedback, review code and
> workshop logs. It assisted in identifying/evaluating the stale
> conditionals for the races resolved from the atomic_dec_and_lock() change.
> Separate from atomic_dec_and_lock() fallout, it suggested to change
> atomic_inc() to atomic_set(pamt_refcount, 1) in the put error path for the
> sake of being more precise, which Kiryl had also suggested in the past.
> The model also suggested updated comments following the
> atomic_dec_and_lock() change based on some directed prompting. The
> comments were subsequently edited or further prompted for fine tuning.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Reviewed-by: Chao Gao <chao.gao@intel.com>
> Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
