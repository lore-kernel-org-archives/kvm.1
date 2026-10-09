Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F39049C4C4
	for <kvm@vger.kernel.org>; Fri,  9 Oct 2026 10:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791540696; cv=pass; b=mxOIq2KVccM8i6amC2jdQeXEGswrEXGDFOMW005VNI395zN3w+acnFGLuyFeOmRdC6X+9KILg9Qmgk3Jyo55oo3HLxTL8feDc5Q5F7Rtm3mrbj3kEl63HrXv1rnbdeNKgq/+kc6bSJZXtzkxhsxgCaMkeTxWZxHbe1jEdt7WMm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791540696; c=relaxed/simple;
	bh=jO2JB94/A3Hvfgi2+EqsO7+q4h2Kbsj1cn+DHY7QLyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YFxDnLM5jZ0CsHW2/58ZMeElrhotpf2zUbImrux0fygaZXLg5kZ1ulxP4w+o30BoLFxTsI62cETl/LdDKXvWr6VgIKQoqBOsyov7p3Ox50H5hJmddRzEsXa/JWzQMPEW9QZNCE2pPZ/08k/lIIszGOZJ2JbA6LVafhGekhgpzP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eSROX79p; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eSROX79p"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5ba429b64c5so5795e87.1
        for <kvm@vger.kernel.org>; Fri, 09 Oct 2026 03:11:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791540692; cv=none;
        d=google.com; s=arc-20260327;
        b=mYEM/k04W75BeTNNoK8lUG1OsVNa+eg1OgPi2wcNdpQyUyYbrP/e90SJHijZSSLQBO
         gH2q72Ct+IIEP228ehBuC3OxXQN1nxY/RiLKcmvRy+Rnz/c+5dZMdUAFNJLmdzeMHklz
         PJHtbbEfuaU5ZZMNM00enyQ9Jk5vsV3COsZThQDEDkMq0LAkQoNEpQO6mXAWCn4EfyCE
         7HnRdMWkH9LBfPT8LV0gQsYR0XSXdG0jHQh9AzX+bQU2A//teXM8sZ0sHcMIct6TZ5ja
         5b6+iicNbogAaIUJQ374Ud3h54F+cyimjfpG92REGIoH3YhxVhPoDHvH67qDBtK2dnBW
         XhFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=X91Ea0i/B9gu1Cdd3wVY7vcLKA2e9/BIdZO5hwAmvwA=;
        fh=HG7/9ury7/gtna/+22du057I5FNhKE+YEOQPTUIx/Qw=;
        b=LJURKC7cjxSh+tOvHp+M4T4aUd2Zm5ag+U2EjMrRhexUBSx3WBQO5qJyDNhVrOLO+A
         4CUzRBhJiNlphueD64QGLEw0hHHnfBLv4i2E8VBmwxEifVpSbo44s/hPRubHF5JGuFeV
         kKR951WeZOcq10Zu2K5zKY4k8D3rXRohm+pbe9yubznaLb9syqUJL4kHcAttBEbMyJnE
         zGX4pUeEXGM9lUfvV6mp5tUlgR+yTSo0v0WTQHTiND7M2vWSSf5s2sGiMaCdml3b0r7B
         5ZG2R66BNSFXseHk06veNtkpuCBRdK5bYsLCWJK5wvFDdPWoPZGPckdEgEKo++QJWoJv
         pZpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791540692; x=1792145492; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X91Ea0i/B9gu1Cdd3wVY7vcLKA2e9/BIdZO5hwAmvwA=;
        b=eSROX79pzkn4hyu7u8sLvL6KKUZYTIFCTxGR45qbMbaDVBNMqAOqZ7IyntCcI/BVr3
         LdN4pF+L1SfV1gL8qgPpFBRSS2QFEhBm4uxUx5+lXKDDnBQYlpno8Zjd8sSKBXPMIcdU
         BoQoUZ1DFCt+9C0F/yCymSUQSymhOGHP4dv++kRKDlFsifGWnaWIRc4P93pJZko6d3VO
         4tFpa+OKIjP46BPCD50Snk3SxwUWend8pYkQ/cMJ7SXteOam9d+8QXKFW2C4dH0ZB8lS
         vEN5QDvtSd1pp6RBfoCpcgMZuVIoRORLx0c/lN9dsFD/Nuj7KPBZ1tFg6cVO7LDx4mu3
         1Y2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791540692; x=1792145492;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=X91Ea0i/B9gu1Cdd3wVY7vcLKA2e9/BIdZO5hwAmvwA=;
        b=dNMa3mi1uHOcPCD0n1Yv3+bb9RI0wxACQa9SaxBcxJWhdYG8hS0wO6H174o94fY1fz
         N6lbFThpAh9W4q2EJwwA5nU1IWhUE0NqkIEBEtsYtUWhQkXHy9dMwaD/xIP9bua+y6dr
         a3U0hQIQGDRpKuPTXaGLi1Mdrfz01BtragGENRb3WJrK8snMuwzaxpqnR+VjpR3G0GAL
         yQC5j7q3u5nVZ518A8bJiJk5jIKXZBzl/1St6Z6c961s8f0OtlGsXpTkbsLKs7xJvZmu
         eoz8c4DJpnkOy2MlsrB3UfKOuzCCDl/QIaLI3AcBh6e9mxyKEJQdODIiC2c6qj9oEY7x
         RfWg==
X-Forwarded-Encrypted: i=1; AKwUvBw8x6vd2yaIBvq4TVFpq5aoZr+DE3aJFF9dEjqKCgPzsWs30g+pPfX87sohFQrsGGcgcwk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKwJydzzYMDmgFVesxNJ1VZ2j7wO6p3WEGy9HtxeVUMh0lZTLPM
	0La87QMR4cTW7b/IUvU5ODzWH4Oyk2TFFcVK+WebTmtep79DE9bd4WDAVT9YLLO+Jer4j1tJZA8
	0yzAiiDhaXrfV8Wki8nsR/UC7+AKoiGLp13LoRbgqG0ZjPdUHkUK9s6M1mVw=
X-Gm-Gg: AYBFou0axMRILMVWAP9SwtHpXSXZWZrpStK4RecJIt8/OM6sFANL7s7ZGUBJGRi8IUj
	StHaSGDu87i+bPlwX3ieFMIc/QFo4d0qA8nj93tq5r82M9Q/0CFGwHDGiOYjcmoXP1A9ozsSYN0
	wsGq9qbzgAQsUzLUssQsRySzMJHHVxXtMVQ5rSH2RD6HozN87/rtkEQu9mf8Eem6rW0MBWCMniP
	ekF2cI43bK43H7y+V1WUjDCTQuk6l+XiBOizMU8LARflZxRNSdgTZvHadbuZJB6grTAHm6A4tc5
	rluwxiPDLE3EhXKA0WL20DIHm8MGjddEEZKST81f5BvfHSBZsb+KJLP2Joc8G99APrDhzX91r0N
	TNRurmkPTmjT99g==
X-Received: by 2002:a05:6512:6619:b0:5ba:4293:fa55 with SMTP id
 2adb3069b0e04-5bcdd5286e0mr89466e87.3.1791540691538; Fri, 09 Oct 2026
 03:11:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007073537.2454351-1-suzuki.poulose@arm.com>
 <20261007073537.2454351-15-suzuki.poulose@arm.com> <CA+EHjTx-niYPnnRDvAAiY3MXLpSYau_PhiBTCiE9mOYUChASPQ@mail.gmail.com>
 <86a4on2qxz.wl-maz@kernel.org>
In-Reply-To: <86a4on2qxz.wl-maz@kernel.org>
From: Fuad Tabba <tabba@google.com>
Date: Fri, 9 Oct 2026 11:10:55 +0100
X-Gm-Features: AclHuK9LIRInATLITNjOUiJu1KjVGIe10ULmW_HxdmRBfJcwxXlgGARzP-Th6tA
Message-ID: <CA+EHjTxZM2kEtsG7+pq7zygA8Mhwzai9PL7+ex1K35BPVSt6hQ@mail.gmail.com>
Subject: Re: [PATCH v23 14/14] KVM: arm64: Prevent unsupported vcpu features
 for VM types
To: Marc Zyngier <maz@kernel.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	will@kernel.org, catalin.marinas@arm.com, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, steven.price@arm.com, 
	aneesh.kumar@kernel.org, oupton@kernel.org, gshan@redhat.com, 
	joey.gouly@arm.com, yuzenghui@huawei.com, linux-coco@lists.linux.dev, 
	gankulkarni@os.amperecomputing.com, sdonthineni@nvidia.com, 
	alpergun@google.com, fj0570is@fujitsu.com, WeiLin.Chang@arm.com, 
	lpieralisi@kernel.org, enju.kohei@fujitsu.com, sudeep.holla@arm.com, 
	jonathan.cameron@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"

Hi Marc,

On Fri, 09 Oct 2026 09:55:52 +0100, Marc Zyngier <maz@kernel.org> wrote:
[...]
> A rebase would be a terrible idea. This thing *must* go on its own
> branch, and not depend on anything else.
>
> I can however fix things at merge time. is something like this what
> you had in mind? It compiles, and is therefore perfect...

Yes, that's what I had in mind, but please keep the PSCI 0.2 check
from kvm_vcpu_init_check_features():

        /* EL2 implements PSCI 1.1; the host must not dispatch as 0.1. */
        if (vcpu_is_protected(vcpu) &&
            !test_bit(KVM_ARM_VCPU_PSCI_0_2, &features))
                return -EINVAL;

Folding the allowed set into the mask covers the rest of the block you
dropped, but a mask can only reject a feature, not require one.
Without the check a protected vCPU can init without PSCI_0_2, and the
host then dispatches the forwarded calls as PSCI 0.1, while EL2
returns 1.1 to the guest.

Cheers,
/fuad
