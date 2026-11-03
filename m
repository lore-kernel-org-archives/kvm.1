Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793715801;
	b=dXWppOCSUoX2UdMcve+Vx7oJvBWseaqFQgZKB69LWsq+F1RnMe2JM1xXCQU3YOlw7xSA
	 vkvBIIPlZ/8d+rqZiPSdnxZBDSd2KP/GlBKaHgig0sEK1kIf2u0LYlCl+2Y4cpiT8TSwn
	 OhoVWNSz2+r78HFnrvWpQn0HwLGjLP44daTEqXUeCpNQg46uC2g1OcW3RGKjlgDLu+RPI
	 /AYCI7RrDjYYJ46y++X1/uKZjjM3UIsmgHJusr5GOpJCm4hY2CC+A573cjRte5+gJCSte
	 2FK/1+8kY6iOkABHDR2L5fAz9jh/rvknNBLKWS8AAJJJTkN8reYmUSgJT0lVBtotG/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793715801;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=FH5m2ZfhAKsc7ESTr6aXIlmL3H0K88jNbIy7JznNN8U=;
	b=YRJa3kzQXxmrCauZ1o7odgXuNt5x4EJo3PYBjY22GUahbu8q4r9BH7DPPjBcqfQk4Ms1
	 yduMOPIz7kI+OIJwHmiyPeUy6sn7vnbH+ToTZm+5t9zREW2NjrH29OFnWG3VKHrD+Hz1/
	 EI5b85miH/HuBt3e7FPbY47OOJsctheQYTPxuVbd7QkT+Ewt8tqwtj609aQVWrO6D00vr
	 E0T6Ll9N9RoKU0e7NfLuHp+AaZRqiKegyzv8ySYtonG6DBia5iBI7fl/JwVcjWZtVxY1m
	 4zWm7d7wPg7kVWHmMvBsxUjDbbzCAogzzBtL6ga3YKNsgDdTJR7dB4cI78oFl9fIMiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=liCMhAUk;
	arc=none smtp.remote-ip=91.218.175.4
Received: from mta0.migadu.com (out-4.mta0.migadu.com [91.218.175.4])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4907F606A326
	for <kvm@vger.kernel.org>; Tue,  3 Nov 2026 14:23:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4907F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=liCMhAUk
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=j/giMBDl/7wt+voQgZBnLNS9pFqFZnvjPU0eYzrRGeU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793715795; v=1; x=1794320595;
 b=liCMhAUkWSB84e1v+3HNlwy7TQLfOQfgEG0s53xWPWiZ3+/dDBEdLyF7HKYticGoDMOuWSaH
 ik1LasPk6ciE+4aGM+zPrU/sb/eV6UXxHfigN2qOjAReniLvzzibvgv7UMyyEOOBx40SzKZSVsB
 4RqWcZGY/3M5ZP2OB8+06MUY=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 48a2cdbce5f37674;
	Tue, 03 Nov 2026 14:23:15 +0000
X-Mizu-Trace-ID: 48a2cdbce5f37674
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5bcbb378fc9so7047e87.0
        for <kvm@vger.kernel.org>; Tue, 03 Nov 2026 06:23:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvByOgx3j8XCjSywTfmHOTUOSsXzf8q3Jb5leA3J/bhjlZtMjsWdMOzWyXaG63X/uo6FYYb0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+xmCRGh98IA75rMDZGVRf4lIvFTPlkquw1sqUTtFRoNTXXoC55
	1EdzBpznZXhcBGlp+vqzPwIQQCJHUe3tquRmtxjvcC7tme6jqI6Mqkl24rdDWubYhSf9Re+pcA6
	Co0NmBxR2NP0mFTbdr7uaw469uH+6KRtEogkGxMqo
X-Received: by 2002:a05:6512:3c8e:b0:5bf:c17c:93a0 with SMTP id
 2adb3069b0e04-5bff0579302mr159986e87.14.1793715792546; Tue, 03 Nov 2026
 06:23:12 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102194454.4086911-1-sascha.bischoff@arm.com> <20261102194454.4086911-11-sascha.bischoff@arm.com>
In-Reply-To: <20261102194454.4086911-11-sascha.bischoff@arm.com>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Tue, 3 Nov 2026 14:22:36 +0000
X-Gmail-Original-Message-ID: <CA+EHjTyX4RO2zDEhuJAu_iu8BsXkNvFBAh2i01fy0Mf=QQ+Tjw@mail.gmail.com>
X-Gm-Features: AclHuK_IkcYbSwt6PamGBhm58rJBGW9RD9jT6VqmMt5IUNnlWXOrPHQFDe_cukI
Message-ID: <CA+EHjTyX4RO2zDEhuJAu_iu8BsXkNvFBAh2i01fy0Mf=QQ+Tjw@mail.gmail.com>
Subject: Re: [PATCH v2 10/16] KVM: arm64: gic-v5: Add ITS userspace register access
To: Sascha Bischoff <sascha.bischoff@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	peter.maydell@linaro.org, lpieralisi@kernel.org, timothy.hayes@arm.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 02 Nov 2026 19:44:48 +0000, Sascha Bischoff
<sascha.bischoff@arm.com> wrote:
[...]
> diff --git a/arch/arm64/kvm/vgic/vgic-its-v5.c b/arch/arm64/kvm/vgic/vgic-its-v5.c
[...]
> +static int vgic_v5_its_attr_regs_access(struct kvm_device *dev,
> +                                        struct kvm_device_attr *attr,
> +                                        u64 *reg, bool is_write)
> +{
[...]
> +        if (IS_VGIC_ADDR_UNDEF(its->vgic_v5_its_base)) {
> +                ret = -ENXIO;
> +                goto out;
> +        }

This lets userspace set CR0.ITSEN before the vgic is initialised,
while the VM ID is still VGIC_V5_VM_ID_INVAL. An MSI (KVM_SIGNAL_MSI
or an irqfd) then reaches EL2 with VM ID 0xffff, and forwarding writes
the same into the ITTE. With 16 VM ID bits and every lower ID in use,
that lands in another VM. Could enabling the ITS be rejected until the
vgic is initialised? The existing its->enabled checks then cover
injection and forwarding. (Sashiko raised this on patch 7 [1])

Thanks!
/fuad

[1] https://lore.kernel.org/all/sashiko-outbox-194102@kernel.org/
