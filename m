Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.58
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793717308;
	b=CDEDdqKcVteULHZKykHUHfTBqU86yTcmj3axqmiCL6oL9c3t+/chvb4NDi8+L+OFr3j0
	 1ae3vHQwYiCqFIGcYRabMWm30JQKazfC1iJqnbFwEeVwEpQLmo3ciEVp1dvW6n/FGM5oS
	 SvYp8sY7OTWQpK83OIOqlphXFZeeiOxSW86uc/9u6dctj45cJ/z77qzJbWNf8VwEItyit
	 9h2EQ7H0kitiDqZItKn8awQINCu7Z1zbQbvhsrkbUdGXtHzLZObgzjtNPQs3ypNeYJBbQ
	 n59Dc3DPrskFuiY2MyQMoGRDbBKQtb6zudhlOKBTt0bcXFO42PVKluW40VMYQRrELbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793717308;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=qwRz5+y1CfI9kDi1iQPoKBCcgpmj5BKvbsT9hE1zi3s=;
	b=2iRBfHgab0kFiq6hF2UkqnLxHSXIJEUjKJ8C4MQsqgdfZTzTU9z+QD/k3FA35AnG5DhR
	 xXuxbOy0+0dVHgQ4fi6HZbaiLLeQW7Ay/Mcpr5jMXC2c1UGnEvbFytMEabrJxSaOF5jPk
	 VFDjDZKvDHcUI30HKmtsC6gYvveZFYaQRfq0VzOb6uxMuqYisak6XqIirvqiCkyrup2I3
	 /m1o1e08eZqRHaXe0ryIdoJdoWSFC2PdN9u0p9yMvoEnTazviio2EJRWjkHrDvxCUIbTS
	 ZYJ7n5tYW7dp8kg7IlSRlJ5Wj5BgRBRAQz+V2ouQBFAZFE0MGAx5tbMFpAi+MIHvx2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=cyutV7yP;
	arc=none smtp.remote-ip=91.218.175.58
Received: from mta0.migadu.com (out-58.mta0.migadu.com [91.218.175.58])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FA2606B269
	for <kvm@vger.kernel.org>; Tue,  3 Nov 2026 14:48:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9FA2606B269
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=cyutV7yP
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=e0EHDUYXYwJ2tFPCvYOXU9vuxX2TbQCMEHzWm7MGEI4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793717304; v=1; x=1794322104;
 b=cyutV7yPNJjkOIlw5TGrzQ3a7nwgvuTrqT3zLSpv8irabZXI1z0BcIqSJsRfvahVty9Yndi4
 S/MV4cRNAD9nvPdDFSYFN88Vm37EDyhqcmbZStHfIcOzuAAEALm1y7N3fjEkkdz+jXD7TjeA6du
 USzTXCpto8D2yVADTQBNhX4g=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4084a72e501b0174;
	Tue, 03 Nov 2026 14:48:24 +0000
X-Mizu-Trace-ID: 4084a72e501b0174
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5bfca2a2af4so6535e87.1
        for <kvm@vger.kernel.org>; Tue, 03 Nov 2026 06:48:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBzqlpT++tl9uFKnpkZ+ZEiANyH8MMUJ24JHg/l9tTXrIVgsMULZzIcwZ+fkubtDmiqx5m0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8xHQwtDbQ7TL305+P3FtBxtdXCRc47yPhYyyNoYCpN2fHzZnGL
	CwqjjDNlQmcRid6sqvigkNq6TnG0Axr43gJZJQ5nTrCP/JL7cbD1HaevYmkrooHMjop6cwItNla
	2Y7HU+dUJzkuGfD11DzQ2bzTwqjgWyMkvqG8+m7bt
X-Received: by 2002:ac2:4558:0:b0:5bf:f067:87da with SMTP id
 2adb3069b0e04-5bff06787efmr94493e87.10.1793717299509; Tue, 03 Nov 2026
 06:48:19 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102194454.4086911-1-sascha.bischoff@arm.com> <20261102194454.4086911-12-sascha.bischoff@arm.com>
In-Reply-To: <20261102194454.4086911-12-sascha.bischoff@arm.com>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Tue, 3 Nov 2026 14:47:43 +0000
X-Gmail-Original-Message-ID: <CA+EHjTyLQKbSWJMb_7kLDiiU2mmgXCEGJo6eaOwq6FyP-0g4Cw@mail.gmail.com>
X-Gm-Features: AclHuK-qvxCnimx5eE-7K4X-2tiMTkkBcU6bg0FMihoezKrSPq8sjEYtl97L8a0
Message-ID: <CA+EHjTyLQKbSWJMb_7kLDiiU2mmgXCEGJo6eaOwq6FyP-0g4Cw@mail.gmail.com>
Subject: Re: [PATCH v2 11/16] irqchip/gic-v5: Enable direct injection in ITS
To: Sascha Bischoff <sascha.bischoff@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	peter.maydell@linaro.org, lpieralisi@kernel.org, timothy.hayes@arm.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 02 Nov 2026 19:44:49 +0000, Sascha Bischoff
<sascha.bischoff@arm.com> wrote:
[...]
> Co-authored-by: Timothy Hayes <timothy.hayes@arm.com>
> Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>

This should be Co-developed-by:, followed by Timothy's Signed-off-by:.

[...]
> diff --git a/drivers/irqchip/irq-gic-v5-its.c b/drivers/irqchip/irq-gic-v5-its.c
[...]
> +static int gicv5_its_set_vcpu_affinity(struct irq_data *d, void *int_data)
[...]
> +invalidate:
> +        /* Make the change ITS-visible */
> +        dsb(st);
> +        ret = gicv5_its_itt_cache_inv(its, dev_id, event_id);
> +        if (!ret && !data) {
> +                /*
> +                 * Invalidation sends events using the old translation to the
> +                 * IRS, but does not wait for them to be processed.
> +                 */
> +                gicv5_irs_syncr();
> +        }

gicv5_irs_syncr() returns void, so a timed-out sync looks like success
here. Could it return the poll's result into ret, so the if (ret) path
keeps the flag for a retry? (Sashiko [1])

This relies on your host series' patches 3 and 4. Without them the
sync sleeps under desc->lock, and this invalidation races the host's.
Should the cover mention the dependency?

Thanks!
/fuad

[1] https://lore.kernel.org/all/sashiko-outbox-194164@kernel.org/
