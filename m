Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.86
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793713464;
	b=TwEaLSrIaV28m32/4DFasg6+Rhbxus79zKhoLkT84eY3IOw90Um8K5gkds/R/wmeZxci
	 IQG5GoSLc+3dQg2JQFrWVTbsSfBkab5bb4cC+eVueCufM9lDcCYiZCxQ9zJ+9hygyXDBO
	 /bQkcgj1C7G1x4Zm4UQZjKtqdpD6bjKJ5iJnQoAkTxKVvoAJbAlexVdtfMankvIrNC8vj
	 HS7mzV/5zQTUQ7UqklPO2dLtmJh9KpKK8FvQixjNK7ZA0CukAvVw2MxENs8oW3twb1kSO
	 98wcfWk8XqhK0HwBWJZmSY4RbxHzDczNbqEiWpuCEwhXK22MAF6KxbS7Zw8mgOZAstw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793713464;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=ZQzTNVyYYgBE97T4osUhW5EzJ8IbgXAyi0t0S4s5/Jg=;
	b=WoiB1obuX8myGxV3LEsdUiAey4xjSH8UIqNtMnWql3pXBrFTEe5akn4GQjwW5/Figib2
	 mmK7Hao8cXdAbJeK6gWKCnAqyz0B/hQtVfpvHJTQmG/rLXPBraPPnD4dQws7QAhDIdarW
	 5DY/eoOaEFYfwdQS66ZogR0wgwUH5ckOvDr086cnYVnOdm888HenUqwYdK9dcCE41dpZF
	 fkBdFwT+yQAnMFyE+3rdGvsiHTXgfstFP6AiG9N90fsz3j11oYdWmc5zM2eHOKLpfy8ST
	 pSJgVrrqKNgoudooJyzlaS3ZzJoS2sbf5j8nqzGvJxUvCAIvWoyOJ8d/vuMwBg0m8Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Xy89gbtl;
	arc=none smtp.remote-ip=95.215.58.86
Received: from mta1.migadu.com (out-86.mta1.migadu.com [95.215.58.86])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E5B606A324
	for <kvm@vger.kernel.org>; Tue,  3 Nov 2026 13:44:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7E5B606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Xy89gbtl
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ZQzTNVyYYgBE97T4osUhW5EzJ8IbgXAyi0t0S4s5/Jg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793713461; v=1; x=1794318261;
 b=Xy89gbtlqZaFqC7BENAk9ZX/zwZFSRGU5sN8hZcsXtvOXR1iAMngrog+lWECHbJu4iU1OlkM
 l1/8fV6mtGCqL4i2GlQC/lzaBoWjo7hfV3ajGfWCgSvauu6/syDrzZuDCCPXftJuEDzTQr+Vi9e
 FZXi7JsVkbFbdle8jVMHWKA0=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 334f9ef57862f87c;
	Tue, 03 Nov 2026 13:44:21 +0000
X-Mizu-Trace-ID: 334f9ef57862f87c
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5be58ad9600so7331e87.0
        for <kvm@vger.kernel.org>; Tue, 03 Nov 2026 05:44:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBwG890syIjLHcL+mCfvIdy7/eillZ95WABEkohB8Ii0Fk5w0li+y2p+MRAdq3Vdg7g2sQY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Rus2K53DFuLiNjUyBTiuxS0sfKigBLFhw2W0JIU7tFNL9u157
	iFPH+lJ1k1fupkHuR53MX3b/dpv0uXgjxz/A4Pl67jqLfaf7gQiJQdbhlCMZOVqW5083COLrxYT
	WLOX9CWB+JikDbC9uIyabWKm/s+uidxOHcadfEHsN
X-Received: by 2002:a05:6512:b1e:b0:5bf:a191:c132 with SMTP id
 2adb3069b0e04-5bff0a75e51mr126673e87.2.1793713455901; Tue, 03 Nov 2026
 05:44:15 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102194454.4086911-1-sascha.bischoff@arm.com> <20261102194454.4086911-4-sascha.bischoff@arm.com>
In-Reply-To: <20261102194454.4086911-4-sascha.bischoff@arm.com>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Tue, 3 Nov 2026 13:43:39 +0000
X-Gmail-Original-Message-ID: <CA+EHjTzGVtvJ76kwU=qVZc9vVvXoVBy88rdU0idHZaCQMa5-MQ@mail.gmail.com>
X-Gm-Features: AclHuK8Yjeg-Kg3bL_DBiJyv5rYXjdrrn_KkW91Lom2D_wZWZ3GsGIHAcTdrDdc
Message-ID: <CA+EHjTzGVtvJ76kwU=qVZc9vVvXoVBy88rdU0idHZaCQMa5-MQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/16] KVM: arm64: gic-v5: Share CoreSight ID register emulation
To: Sascha Bischoff <sascha.bischoff@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	peter.maydell@linaro.org, lpieralisi@kernel.org, timothy.hayes@arm.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 02 Nov 2026 19:44:41 +0000, Sascha Bischoff
<sascha.bischoff@arm.com> wrote:
[...]
> This keeps the IRS behaviour unchanged while giving the ITS MMIO
> emulation a helper it can reuse when it is added in the following commit.

nit: the ITS emulation that uses it arrives in patch 6.

Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>

Thanks!
/fuad
