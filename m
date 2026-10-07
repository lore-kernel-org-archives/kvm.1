Received: from mta1.migadu.com (out-251.mta1.migadu.com [95.215.58.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAFF48EC8B
	for <kvm@vger.kernel.org>; Wed,  7 Oct 2026 10:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791370369; cv=none; b=OTESHcqw+UNvcEAdRT8XgJ0RlP7hc5E/CYjlL+EBGDVpMxAsGAPWAWZhrqX/m0wcxPwevKL78CQ54CsW0y4dAvj/MXYQk5CBeFmKNdvyHYZsmC+j6TXCQZOQbjRpKunaTUmC3cQGLLiJWIvlZD5bZELoba9ahmmpnNqKEf8/3V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791370369; c=relaxed/simple;
	bh=IYj7GJMoI4iyh7cvdiMZ7m7A/3iJ5WzI14Ui9Zh8zRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X/zNwq7to902ksj5oBjLgvIRxbRckGAx5Yo8C0IBeaUxy8fjiyTBnx/2FAuYD4Zp7FhHbleBYk/zjcVil7xA1vsknZI/qmqww+4htTxWqVzlDOZ4ZyeAuSIzwm6dTMW21eA4WTpSZNtKnscp2Szn3YIqZ1BNV0gLLDKSZrSERrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LxvogiQv; arc=none smtp.client-ip=95.215.58.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LxvogiQv"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=IYj7GJMoI4iyh7cvdiMZ7m7A/3iJ5WzI14Ui9Zh8zRE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791370337; v=1; x=1791975137;
 b=LxvogiQv21xsbxJN0eZXyL96QF3EnVfTo0Leotc6UI2EabcKXarJRubm5ctOB+4KNERIfgul
 b2RA1v1vqBzYRPwa/tumO7TPkI1rHUpgvCv5SJY3x6JkfzqydQv7lF+ebuotfUe8pASWNpjbG3K
 elu7xmGV8+e8mj3vRBfwTOg4=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 88c28ddec8e8da56;
	Wed, 07 Oct 2026 10:52:17 +0000
X-Mizu-Trace-ID: 88c28ddec8e8da56
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5ba40832934so5683e87.1
        for <kvm@vger.kernel.org>; Wed, 07 Oct 2026 03:52:15 -0700 (PDT)
X-Gm-Message-State: AFq9FYJjnFPhVP+zsLuLUNUau5zquw+v7DDi6aVUBrc23CUDCWUld3Lu
	CbgPfPDbnw+5WTPA/EgE6wPugv6dqS/BAp5eKdG4hawrqjWyASYWLCMskBy4OOOAvLWJjEgvTl2
	3VZfyu3USpV/2uA/AwkYrMFx9Qnp5f+Q2XhdAMdxk
X-Received: by 2002:a05:6512:a89:b0:5b8:f20b:350c with SMTP id
 2adb3069b0e04-5bcca123ca8mr312158e87.3.1791370334717; Wed, 07 Oct 2026
 03:52:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007073537.2454351-1-suzuki.poulose@arm.com> <20261007073537.2454351-3-suzuki.poulose@arm.com>
In-Reply-To: <20261007073537.2454351-3-suzuki.poulose@arm.com>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Wed, 7 Oct 2026 12:51:38 +0200
X-Gmail-Original-Message-ID: <CA+EHjTyb3-QoLa6P-dGXVdMh9E_vO3p8HceH3TH8h8gPJSd1Kw@mail.gmail.com>
X-Gm-Features: AclHuK9KvLpSDQrj6i2mZweuyXItR2scaGR6GbHNtuuSCxJB5qE1qI3r7GdrQYA
Message-ID: <CA+EHjTyb3-QoLa6P-dGXVdMh9E_vO3p8HceH3TH8h8gPJSd1Kw@mail.gmail.com>
Subject: Re: [PATCH v23 02/14] KVM: arm64: Disable Steal time accounting for
 protected guests
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

On Wed, 7 Oct 2026 at 09:35, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> PVTIME support is advertised by KVM_CAP_STEAL_TIME, which doesn't take into
> account the kvm instance. Even with that, a VMM could skip the CAP check
> and proceed to configure the PVTIME as we don't do further check on the
> DEVICE_CTRL. Tighten this up by passing the KVM instance around wherever
> possible and catch things early.
>
> Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Tested-by: Gavin Shan <gshan@redhat.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Someone beat you to it. This is already in kvmarm/next as a5b0f36a045e :)

Cheers,
/fuad
