Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795537035;
	b=Uqol0g/EIRw8kwYozuxgzKgcbLHTGm23QMC/X4zMyY+krrjkcXlSd70TkFdHqdI4WbKH
	 0R0LBjraHzV5m3YVvvqgBdvMrDZzfpxsmO6T1stu7rKeJIFZe7plJ1kJ3XOj8FgP123WR
	 2WHxc+d1eGeweyjr4/n40XU1aSk3oNitL1GYNY43qOlK9Cz8DISZ+US0B63APRvzOA/WM
	 xuJpHdV6NbaulIWmGfPn93BoUX6A+74JbDsyRNgO6y0sG9xOSsAH5BYXUQEwxdmg4Jn0D
	 KHF24+EFVwH3ZgbwXXigS85d6vqxTlHKQT7sX/HasM1Vc8oDKXAI+6cszeCjyzsvoxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795537035;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=kxblDUMyGzlr1U89kDKvE9h06l9IfZFAg9l5rlO4ajU=;
	b=2sFxrSONLp9Xp7VU4sFt9+WpxtUjonz+R0crcJCRNImD3e5+0cVR6pImF3hLTk09PwZ7
	 VKpg7+iwfIe9ICEOTBrW7dP2P35IJXKgq/Haqm3KTXuUktLNXyWTfWy+RCmRmhVHhCXtL
	 jDZeqEqKfYMNnqxYIFQwZu6xB8r9RiNQsRLtlrON0tktLOYXAgS8tswOjPvNmh8kg7Ain
	 oozWZK9w7L8E7JjfG2GUTQy/Mx8eZI7UPFkBnhRFFt4CH7in6iZ9WK3LnjLuOeOu55b1q
	 UmuqHdlsQnSz8fWF30kBoRJiCmlLVTN6orITnYqamJHJLG4nrsf96iMRJRx9yXF4XeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--zhichuang.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MqnUGJf4;
	arc=none smtp.remote-ip=74.125.82.72
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCC1606A687
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 16:17:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DCC1606A687
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zhichuang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MqnUGJf4
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-16bc6f3fdb1so3006594c88.0
        for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 08:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795537034; x=1796141834; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kxblDUMyGzlr1U89kDKvE9h06l9IfZFAg9l5rlO4ajU=;
        b=MqnUGJf4PBQllfL4pZhuqm8ZVcXVjNyJtdZE91sICcdc5uvkhKkyspFEwwoA9BrJe5
         nDIgAHSqaeGy25QDn3WJJxZWWT7kcr70aPkwXyBgnn4AXbti/6WLmagsYh4gG0rSl0Id
         hhjxNXc0PhD/8BETBTaZl2Pe+EHDefc+8NX4PaSfVuuAmTZZdsv6S8jfYqLD9L+ULbwy
         Uh8WHNCaHrU7Y24m0vL4vdglriQ1Vy00O/8D9tW4u00Iqq/6KIz4CDsF42TXyd1RGgxf
         xgFAt1VEScdlMzTSHNimISzCwb6GYJhdju936os43JGPwSng1Wl6r7eG0/qVc8CLaC16
         TIiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795537034; x=1796141834;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kxblDUMyGzlr1U89kDKvE9h06l9IfZFAg9l5rlO4ajU=;
        b=XE/Q2fridNLYVc6wSSm7I+Z0JEJOw6iZ6D4X1jcnmqZUONpphwHa9ual+Vz5XP1NMt
         PD+5ywdEgGBIbfxA7SLVN/OvKYYG6BDTOAVJTSeh9YMBxSB069CCt56MaG/dMmjlJZT1
         uhCGKGxwc3VyIfbqWTsUtZQvVG3B85hGzW76Cdy95LFYfM7ucvoSZ7GNAfsI6+ROjoXu
         X6Y0RJVjzer9ZCeuLu19TwXqjZhBwyDS2fCD4qu8jIUCakNjhw7EvC35uHTc1KfaDj20
         7usG1fLCGU60vNpDY5nSdeMEQXSaiPcvz/jw3hDMrt6XpbjjUxpfLAkr7OqyvPNMcFcW
         Oa/g==
X-Forwarded-Encrypted: i=1; AL+hErEdEWoyjUh134NDCLkfSF0sw2DfgD+BN4gHgnfyoZYNzdg7nyWp+QDRtyCMoE6iX9Ar2aQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/OZcZy1KBQlgIJBl18Ln4XfqfT4Z3HGIlGUrEb8HYcrQWeIYWE
	8fzBJ474lSqBYtp0KxK5JE1A772XWQ+qBLc7SFiqBDfo0aqC/2fkYoE1BZeZ+ZWEpjyYIsz1aWg
	n4kMiar15UsDJtuftIQ==
X-Received: from dldyr25-n2.prod.google.com ([2002:a05:701b:4519:20b0:163:a42e:b837])
 (user=zhichuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:701b:2089:10b0:151:2e62:fe8a with SMTP id a92af1059eb24-1b5568feb61mr15349607c88.40.1795537033939;
 Tue, 24 Nov 2026 08:17:13 -0800 (PST)
Date: Tue, 24 Nov 2026 16:17:13 +0000
In-Reply-To: <20261123083337.2731019-11-aneesh.kumar@kernel.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261123083337.2731019-1-aneesh.kumar@kernel.org> <20261123083337.2731019-11-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261124161713.263759-1-zhichuang@google.com>
Subject: Re: [PATCH v1 10/10] PCI/TSM: Configure accepted device DMA during
 driver attachment
From: Zhichuang Sun <zhichuang@google.com>
To: aneesh.kumar@kernel.org
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org, kvm@vger.kernel.org, 
	driver-core@lists.linux.dev, djbw@kernel.org, jgg@ziepe.ca, leon@kernel.org, 
	yilun.xu@linux.intel.com, aik@amd.com, thomas.lendacky@amd.com, 
	ashish.kalra@amd.com, suzuki.poulose@arm.com, steven.price@arm.com, 
	bhelgaas@google.com, jonathan.cameron@huawei.com, lukas@wunner.de
Content-Type: text/plain; charset="UTF-8"

On Mon, Nov 23, 2026 at 02:03:37PM +0530, Aneesh Kumar K.V (Arm) wrote:
> +	/* driver_managed_dma is unsupported. */
> +	if (to_pci_driver(pdev->dev.driver)->driver_managed_dma) {
> +		ret = -EOPNOTSUPP;

Hi Aneesh,

A short clarification question on this check. Because it runs before
the accept check, vfio-pci fails probe on any locked TDI once the
platform TSM implements dma_enable.

Is rejecting driver_managed_dma a scope limit for this series, or the
intended long-term policy? If it's a scope limit, is the expected path
for in-guest vfio to enable private DMA when iommufd attaches the
device to a trusted (TSM-owned) vIOMMU domain, rather than at
pci_dma_configure() time?

We have a user-space accelerator driver that uses vfio-pci on an
accepted TDI, so knowing the direction would help us plan.

Thanks,
Zhichuang
