Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794760670;
	b=KKK3djiYez7l/UqsLVWwA8aK7uLqVYo4OtPrrBNq0lEHfTZ7LWRStQR8okntv/w5nUBG
	 6KMHvw3F9Bhu2FJd/ncvKibTbv4ykAIBD0M66czPgPYBAmeUTI232bfJNJlWoLZNIkQeu
	 Sdh9uQSfOC4u3BDCQOBPDrjd79A+FEEVUI9e+1lU2JnO+TzZtz19a+YYFJoCbjF0SjiK1
	 5VwwrI+ZjS3YQhJoYPGzfUT8s02gNGif4iho0vhIlJ1BcSkMgNJ9yKyDJQM8YGbJ7wtFp
	 8t8Wh2Ck9yVfrgl+A8pdY+RaFHxdBTjJma7LOewXz851mFixNq+Kv1HcROvmUzfRs1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794760670;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=1U+yE/obeyFMHp1b1KSSrPt1HPsDkzs4IHk8voDIqqk=;
	b=AjbmYDw3adhKr+44tykpAiaH5Hfv+Kghdav3s0Kfv8yQsX6bvgTaBxJpaCedR1OhDO+u
	 vxAtyax+3J0byXhTGEk3Ihw9nMWKgSFYYKXNchLh/AMAT8DbdD7wFi/9N6IHfHvcM73DX
	 JR8CCs9TpBw4Hw0HlhwfEnrUoMAH50NIXSB7ZettH4Zp4IcgZTjIl0AjCT1Ke13oUVNUy
	 u5+cIMq4I7gn+BfPfNgxrIVDzFAEsMvvLnU0ZiY+Y+cg5ML1EHen9N3BNoyJFnJk+1N5H
	 TAD/98dra9J8SJgoO4ohFDx4Ev4CJcAeqgNewInEcgY2Chk65fRUSNuLOWSYhtX2MKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KBSlBA0N;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B90F606A31D
	for <kvm@vger.kernel.org>; Sun, 15 Nov 2026 16:37:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B90F606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KBSlBA0N
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1a8cc11ac42so2337655c88.0
        for <kvm@vger.kernel.org>; Sun, 15 Nov 2026 08:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794760670; x=1795365470; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1U+yE/obeyFMHp1b1KSSrPt1HPsDkzs4IHk8voDIqqk=;
        b=KBSlBA0NYi/reGrFtBdgslKCW+KFEUrvv0yINuj0NG4mI1M06no7/8D5igBpPX2ywK
         0ltdZN/YeBVG0mn/1fYetWgtMYZ2CmyLnXz4tUY2OyzW4SPeR/6S4gwhLaEvoYh9nZDd
         ovTZ7XN/jIF5qInhAg4JgjWtCqOhfVw+JXk3KTkL4+iDKymOxQLFz5A9vPuu91CGlErT
         JlTrwDE9eQCa7qbuADH0Z6trj35q8luOmOfLbl7KNkT6Nc9oBcEeT7ycQqor84MUjBfj
         JUca+BaXyVVM+WTB9hNRNJAOPbcg7OKMCdtiEs92J3gRUo0ovA6WT7a9WY7bIfaVeXgQ
         pBlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794760670; x=1795365470;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1U+yE/obeyFMHp1b1KSSrPt1HPsDkzs4IHk8voDIqqk=;
        b=L2i8ScdyA/DkLXn0sr5EALf7KuqU9ahIrPxJjm/QYuHa9M7HSE6ZrlgODX6xAG3jQd
         0YlFK6MHOf25ulCq9wYXYXwI2B51m8sxf1z/m2cGhtPo0uBvVkTQB9gKICg7J1Z4687Y
         0/ywpnBHrdUkEqZdFHsy2DT7QvHC8e6DPnKs4DOjcf+A1y/SqrqnuGAjlzfDhfThiT3Z
         u0lGTW5Yf42MBD+J0FDSvLmIcLtQTkBfcQmgtSt2rxwrH8LVAZkMJY7eKEDwYSnLh3O5
         n1VSLBcHkSuiCQ7gA5hniRG3jC6FgCwKDDKPo5UD93CaTDVZbMPsIC/meGl5Fm3cwd8c
         nGog==
X-Gm-Message-State: APuU4Z/srfR3ETlQ/3irge0kwXbv0HGri0lOB/e/6M9VdSbN+KFFreZs
	m90BLBrtVQ28ko7povte6OApfK6Pl/kECT5+HlkDTDHeBp+mzHS19TsG
X-Gm-Gg: AYBFou1jXXe5JjcgpTtSEhionE+5BGbJBjI9fkIlHMFnGqVk2Fay7ee6mNtA0HEorF1
	jlAYcIFgcUEBF+aCI8Gk9z19Um8r9XASVfNKJNWh0fQC8K9q6pApoiVtokpTA6Dgcx322+yMatW
	4oFVBsItJ6PKJUclWKaDPQbhRx/+Yj2rydCzl1PdDHuhM0OuEUxsv1R82hj+netv4xl7HdrFNev
	vECnfi6j5BDCScQYv2ekQ1390k5Vj0Sw9uFUoPbkyxXfvlvn/vDwBENCWGnQJ2ZzOo3DVvxAg7A
	kaAq5YGDadF6lvfHH1locR03kL8T8+MjMJhjn7rMMqhiN7oWpTbtot4Li44xrGkPnb982F/YCE2
	GmgAf8n+V8YAQeigNNqJVtZ8DIwDi59w7FqYBKVaVehuxmWtpwPA9skF2yDIcuRElq6Pc96UUJf
	66qLWO7aX2TO44K8+0RcU3H3rjLREkPvuHttmiV4TquIxiLVJw0erKi/K4Tj4get1zhhSgZXyC2
	eKaMh7TaqGp0lSYXehZF7aTLiAhvLAMRTulouJublJIyQF68CqVnk8sS0bhLWY0gcF4EB4MB90r
	jHdAdcksXZXNnVTiC4rEoBI7yj9Kd11Ss7nMdv/n+5hUubzfOGqLIouIY8bir/b7LXK0
X-Received: by 2002:a05:701b:4508:20b0:163:c5eb:d42f with SMTP id a92af1059eb24-1b503060401mr8812803c88.5.1794760669556;
        Sun, 15 Nov 2026 08:37:49 -0800 (PST)
Received: from youngkk-vm.localdomain (67.216.200.102.16clouds.com. [67.216.200.102])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031b98e5sm26440037c88.14.2026.11.15.08.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 08:37:48 -0800 (PST)
From: Cheng Yongkang <teel4res@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [BUG] KVM: irqfd: resampler EOI can go to the wrong GSI
Date: Sun, 15 Nov 2026 08:37:41 -0800
Message-Id: <20261115163741.227220-1-teel4res@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Paolo, Sean,

I hit two corner cases with resampling irqfds. Both need the VMM to
set up IRQ routing in an unusual way, so they may not be worth fixing.
They come from the same mechanism, so I am putting them in one mail.

On EOI, KVM maps the irqchip pin back to a GSI and signals that GSI's
resamplefd. The reverse map only keeps one GSI per pin, the last one
set up, and it follows the current routing table, not the one in use
when the interrupt was asserted.

1) Routing changed while a level interrupt is pending

GSI 16 asserts I/O APIC pin 16 through a resampling irqfd. Userspace
then swaps the routes of GSI 16 and GSI 17 with KVM_SET_GSI_ROUTING.
On EOI of pin 16, KVM signals GSI 17's resamplefd, and GSI 16's
resamplefd is never signalled.

2) Two GSIs routed to the same pin

GSI 24 and GSI 25 are both routed to I/O APIC pin 9, and each has a
resampling irqfd. When GSI 24 is asserted and the guest EOIs, KVM
signals GSI 25's resamplefd, and GSI 24's is never signalled.

Both were seen on v7.3. In both cases the owner of the silent
resamplefd is never told about the EOI, although api.rst says that
when the irqchip is resampled "the gsi is de-asserted and the user is
notified via kvm_irqfd.resamplefd". I could not find anything in the
KVM_IRQFD or KVM_SET_GSI_ROUTING documentation that forbids either
routing. setup_routing_entry() and the EOI path are unchanged in
next-20261113.

A fix probably needs two parts: reject a resampling irqfd, or a
routing table, that would make the pin resolve to a different GSI, and
keep a routing update from changing a pin that a resampler has
asserted. I have a draft series for that but it has not been built or
tested on the current tree, so I am asking first whether you want
this fixed and in which direction.

Thanks,
Cheng Yongkang
