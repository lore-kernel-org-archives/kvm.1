Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354DD46AA61
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 09:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790933070; cv=pass; b=D3vmLyMZR/34H7hdbyP99jvNS3NrCiVGi67hLbvvwEKhxM/GQpa2E34XjUByZUrJd07GIvzBFfDyGKbIPH78RYLZs2Pr0IsO90WG20I/kerAIbf9NY6IpwTWTqk07CsE+QXVX395n575XBYXKHbuH+JzMkTYVOKxZgYIQrLtomc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790933070; c=relaxed/simple;
	bh=7PmFoTV1MhIrlyB9q/nIr5bTRr/fQsMqTgmO60KsB8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NsUz4V9a2IGJ72OFALD9cLQfDYo7TTIkp9GoLdyq7I5R5EQHea++Ti8NLPnUgyHNRGdjoOold1xUqGd2VEPjJ7/sddkRLi5WJzoRm+07b2TgcVYfpUGZ1mms8n40UFaQhhcuSVonbQjNzUIM99DkAEWtmxiShmp1nJbaRrT9rj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ARP0Bu1C; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ARP0Bu1C"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5ba4065fa07so6419e87.0
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 02:24:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790933066; cv=none;
        d=google.com; s=arc-20260327;
        b=j/HdFd+Nvc/JFa2kw9XMNgGEKRroA3H1SeZ0nrFvuksMCSPhAmAV3fubeFBB2vhnnU
         tns6ouXmgtJYGbHHwrG1c6FVSjW9QiUWrG6DxqjsZn6i0vdRfE5QaR5CwBsTmkjd3/GD
         sInnBEEcUN1YHV7OlYx7CJKYpoqvGgD4GuyTrM2BD+/FfNhPnRd0DP8pc1DpeDTx96/m
         j+mM6OBc1YlMffE/qbPXgRmgIdNhYIB5w0/9jnDhv28aLCu26ca+zhmRdYXu4dcbf9qT
         tBglYmOhgWBI9DL8nbAYdQYlk8Mqa8Ep5o+Fql/BRGGeuWOawjoa0V28ImIHEmz1YlEs
         ynMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7PmFoTV1MhIrlyB9q/nIr5bTRr/fQsMqTgmO60KsB8I=;
        fh=rnIkUf6r+pm8oCQPQDOHPhdYLJEIYxB5Eh3hMNjkNs4=;
        b=ExUFVr+nNkwMgCvMdi+157YqezO2sUFVl+MWooCUWWOGuzwVH85SYZDPrFDZ+4dZ/q
         sYVG0IWWVCk9cbZ8mf0aKHuMgXlhhSRqs82OXyna9ZDIJAswUPx1qxxzTtxVICNzHeDe
         boqJU4NGeRszd9fyS8oXyNAd/ShWS7xQNU4OYAWFUc5DelYT1s5vjN2/uM1wZWu5GhLW
         k3yyEwZv8/jt9fX0ee3aBJSOruEACehiuUoPCNvHSyfqwWq0UgKI4iMv+nuwV1PjzhVX
         8qFw41Ba+qYZ2EgY9CjcF0MlDJ1mCZCoKZXiNe6KHZarV5K3rfT6fWlKcogqnlTgJMLO
         HB+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790933066; x=1791537866; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7PmFoTV1MhIrlyB9q/nIr5bTRr/fQsMqTgmO60KsB8I=;
        b=ARP0Bu1C8XEPPsE6on7b3PkqYH7IR7Y+6Nln/Jmj1l+Xw08FUBTjOFpP+SQKPNkQdw
         LTIf2ZF1BlysKAROzOShdW1sY6Pddoj+q0ZIkZpq43A58G+dYAA+1PkVDXjw4Ocx9K0l
         8LhYzSQY7qR4G9sPOqalrMaWJRQc8jsE1g9Vx2BniTInxKTnWFPqXz6GCF9ttnNJZwkv
         VbkB1xuVczdlz5UXvDn8fNFC/D6RL39iTOYj13OPc/44e23EmrBS8A99zFHlFX5YQwdR
         +HMLamDY5GZDjvLpGopvrc8LEZwKisFC9mULn9BhZLMGpOqd8TVRGVpaVw6JpBCDs2kc
         ygYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790933066; x=1791537866;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7PmFoTV1MhIrlyB9q/nIr5bTRr/fQsMqTgmO60KsB8I=;
        b=Z2A5BpladDam6N9T3q2HNPdbwL8HCy/PHYLuOIognDVWtaOeAalIW0POFhthj/qMQJ
         2WqIvjuon8VUz8Z8BKz6FEPa/rVsgkZ/Cakkv5tUNj7Y9psmDhvbTWevTRXIDxhO6tkE
         d0r2IefIP5S7G+gyHHjEelCXUG3+65JvgA1ok2EiGWAOuNYKfdwVbYt34JhYmXmI3kVV
         817FubNSqbTZ/MWHR+9VQoNdANQlcv64u/SWKc2URMu8VgvQJEJY6rK7HrRap8h0nWE6
         ddXjHaYS2XRa98qs5NvWSGl5hmAjnzBI8DWmtGKUO7q1e66RpbSGiJhP+KRmBcs5tjTY
         2RQA==
X-Gm-Message-State: AFq9FYLimvlikAUdTEmCmiK1hzj5ostrVOsNBNpdzp4n0ZXyyWco02ib
	ghjXnFqaRyRcjjJ0g1GsemlF5xzZFAPHB7ey7xpiqrQf2ZUR+tP8tHHm1m27R+Umwlvsam9XQaK
	YLjwprbQq9SU20jC9Wilq861t0uSnlrpcutC405Zs
X-Gm-Gg: AYBFou3TGOsQ3+hMAWljLCbKT0h+l0fDxnY04EW3mZ+/2tejQm4kd1XpVPy9m/LNdfj
	Q6EANHZYuFr/l76fUb2ywsUL8qxc1Mm27KscsuljqP+bsngbIByJHJbkzuTGziQgOsOEPq74p1p
	eNLn8JhEILq668ZDWywrh5quh9HlDZOaxbKMnBdR0ipPbPsjHPTDGPCWxXrAbO1VtXxj9nZ8MS5
	iwS7yEkcefYxA1+M+LkDk99IN24y/NhlVK0kFLRxS3MQUTGVDMEdBAmMjjAJmQxtNb1ezh7zE7B
	XqCYVLPzc0qk6eILSQsF19YnVV8lUHb7+Uv6Tg7Zo0A0AxZV7x088i2JE0hEeqv28b4rzQp9MxP
	CZVOFRx0LVM8cbg==
X-Received: by 2002:a05:6512:b8e:b0:5bb:ff6f:b4bd with SMTP id
 2adb3069b0e04-5bbff6fb595mr82503e87.14.1790933065552; Fri, 02 Oct 2026
 02:24:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001210703.1597150-1-suzuki.poulose@arm.com> <20261001210703.1597150-14-suzuki.poulose@arm.com>
In-Reply-To: <20261001210703.1597150-14-suzuki.poulose@arm.com>
From: Fuad Tabba <tabba@google.com>
Date: Fri, 2 Oct 2026 10:23:49 +0100
X-Gm-Features: AclHuK_iAoRmEqRhd3Pqw1bLNIyTQ_Nu4t-bE7ReQMk3jjFJ4DGtZ7fagNuCSDg
Message-ID: <CA+EHjTzz+nmaMDQBXt2e4RU8YcsJOJkVevygJHsq_jbon8PsXg@mail.gmail.com>
Subject: Re: [PATCH v21 13/23] KVM: arm64: Mandate VGIC v3 for pKVM VMs and Realms
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, maz@kernel.org, 
	will@kernel.org, catalin.marinas@arm.com, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, steven.price@arm.com, 
	aneesh.kumar@kernel.org, oupton@kernel.org, gshan@redhat.com, 
	joey.gouly@arm.com, yuzenghui@huawei.com, linux-coco@lists.linux.dev, 
	gankulkarni@os.amperecomputing.com, sdonthineni@nvidia.com, 
	alpergun@google.com, fj0570is@fujitsu.com, WeiLin.Chang@arm.com, 
	lpieralisi@kernel.org, enju.kohei@fujitsu.com, sudeep.holla@arm.com, 
	jonathan.cameron@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 1 Oct 2026 at 22:08, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> pKVM does not trust the host. Realm VMs follow a similar trust model, with
> the Realm Management Monitor owning the protected state instead of the host.
> Add a helper to identify VMs that run under a host-distrusting hypervisor.
>
> Use this for blocking ioremap of vgic-v2 into stage2 and prevent creation of
> VGIC other than v3.
>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Tested-by: Gavin Shan <gshan@redhat.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>

Cheers,
/fuad
