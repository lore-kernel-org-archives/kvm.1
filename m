Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793721768;
	b=QRbxChsMmJSRhh17YiToXqrUudEeFJlYYVJfHMCWIFYUfX41AI1gB4gvsxoVAbwh5C0A
	 xXD0BoPEs3K+F9n4BE1b6RxQ9R6Sl+WqQ+04vyrRqd0EwqBuEp0kM/MIdKmhgoI4DDZE+
	 T0pDizol9+o/WYGBsGR1KYMqgZrrbY6cjfvXwaFDxFfSwN54wpizRsr2mxhv8AckgAdUp
	 o+kAhxNGRoo2myhYhhiD+4toZDd6+l1as0ckX/mT6EpZjoU6COZXYPGRnIOYYu2C6tvEa
	 rgblMqyVzs9xduakGIxllBDywIidWzFn2t3Y/U6h9mVU+nHYPXVruOV69+c2OZnwLnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793721768;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=zOCB2yW7H1L7hqWLuRwpPyC8dh+ZZPOknwvDqx+RYXc=;
	b=E9R/DOMs7ggjYy2eZxWr1ZPYj2sBkSyGOhihiOIW0QN0YPhuBFaM6JQgb7zeHvRyOTLf
	 JRFEbwmOLhbdXEGzy3SSqWmUNDNEnjoBFg+AOBMw46LOBRAkf8yeqCYHfgNKGk+1ruWbx
	 qequ3Fv8L9uh+SK9uOmWkUjc0XZSSZqEN57c1bNEGtt4OgWvxZGTvSgBEHinFagrZo4eO
	 wsOAK1SguRqIBdsnJ2qBOn37/t+P/vCOMFpcOiNpFET0fbmjFHJ/H5dnoKE/BlZuYnuDn
	 8P2BMjFjJKdQ7G9F7Wst7ToSA/ZmdZy/9iLr6wiJTdaafcNbPBsNxrR+mAK94j+UH8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=hAmLRhs8;
	arc=none smtp.remote-ip=91.218.175.13
Received: from mta0.migadu.com (out-13.mta0.migadu.com [91.218.175.13])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B326606A326
	for <kvm@vger.kernel.org>; Tue,  3 Nov 2026 16:02:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B326606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=hAmLRhs8
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=zOCB2yW7H1L7hqWLuRwpPyC8dh+ZZPOknwvDqx+RYXc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793721765; v=1; x=1794326565;
 b=hAmLRhs8hjqlX49Yb8DFdoKMiM7RiQz3gRGEEuE/fnmIS3sX7UFXHWXs4u+wMCvWd70mPyev
 HT0S9hy/j8M0npSDcRPEXMO465IxrwdrbQ23ZLG1M9+FVxX+Wr2NvEUE8VxTL7BHpKJmadPyDvQ
 MNjiKMwq4qBG4sg+KYes9Ds4=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 07279d7dbfed4624;
	Tue, 03 Nov 2026 16:02:45 +0000
X-Mizu-Trace-ID: 07279d7dbfed4624
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5bfca2a2af4so7476e87.1
        for <kvm@vger.kernel.org>; Tue, 03 Nov 2026 08:02:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBx0Ri5lcjz7XfXz+A4GLqzBXicWdWMNTSVQSBb1IewcEAjgLc7XX6gnkd3LFM6XhleCwzs=@vger.kernel.org
X-Gm-Message-State: APuU4Z8q5Fva5K5uF62NiILSeOge29LWI8OYUDRUFSWP++mbvW3NljTa
	iP2FcaCFtRRSl/ta5W1w9o5+N+nG5nNXx6i5rOWFizIwsR71CL+FP+3XvRHLeAxchAwmGs/cwam
	NSBrk1T8AXATSp5VINeQkqBhxK3vpZPyFNmCY5pvh
X-Received: by 2002:a05:6512:308c:b0:5bf:f368:d60a with SMTP id
 2adb3069b0e04-5bff368df88mr6002e87.11.1793721760355; Tue, 03 Nov 2026
 08:02:40 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102194454.4086911-1-sascha.bischoff@arm.com> <20261102194454.4086911-16-sascha.bischoff@arm.com>
In-Reply-To: <20261102194454.4086911-16-sascha.bischoff@arm.com>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Tue, 3 Nov 2026 16:02:03 +0000
X-Gmail-Original-Message-ID: <CA+EHjTxFT2AeAj-hvuQW3h+u7p25wVpo9CA4QZZrayQW-KOBiQ@mail.gmail.com>
X-Gm-Features: AclHuK_ewwkMxYhH2NmdYQ5NcJFK1vnOJxwlqW6fDvbpSmhufUmI6wkocmqxpCo
Message-ID: <CA+EHjTxFT2AeAj-hvuQW3h+u7p25wVpo9CA4QZZrayQW-KOBiQ@mail.gmail.com>
Subject: Re: [PATCH v2 15/16] KVM: selftests: Add VGICv5 ITS translation cache tests
To: Sascha Bischoff <sascha.bischoff@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	peter.maydell@linaro.org, lpieralisi@kernel.org, timothy.hayes@arm.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 02 Nov 2026 19:44:53 +0000, Sascha Bischoff
<sascha.bischoff@arm.com> wrote:
[...]
> Also cover negative MSI paths by checking that KVM_SIGNAL_MSI rejects a
> message without KVM_MSI_VALID_DEVID and rejects a message whose address
> does not target the GICv5 ITS. Finally, inject once before guest-side
> ITS disable to prove delivery still works, then have VPE0 disable the
> ITS and verify that a cached KVM_SIGNAL_MSI delivery is rejected with
> ENXIO.

The MSI just before the disable is expected to be blocked (IDR1 is
narrowed), and the disabled check runs before any cache lookup, so the
final ENXIO doesn't test the cache. Could the test restore IDR1 and
deliver an MSI first, and the message describe what the last step
checks? (Sashiko [1])

Thanks!
/fuad

[1] https://lore.kernel.org/all/sashiko-outbox-194181@kernel.org/
