Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F31049E5E3
	for <kvm@vger.kernel.org>; Wed,  7 Oct 2026 11:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791371995; cv=pass; b=MRtrmXu6VD9KYuWyUFaaKwiP4/u3X/+prFD1zxzWzv39+4ZsmLXAhFZWiUQqs/Q1O+uzGuebgFKDlf6XPSqnALMjeZfZmUv6gy3eZ9F33p7eVMw5v/fQPBXuZMG9lA8v0cMaQOXxIE0hJcgAbIRV9c2d/gzRXUn7gusxjJ0p+pc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791371995; c=relaxed/simple;
	bh=VTU69CrXg+oUNUa21qt+heVePxURpvvJ4P7YR2kHJSA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=glms/4V7k9j+CGJjAdgzIZfRb1OkJsUsSgMpZ/lpPwj/BosMLHTf/zEW2FMZ/geMBjRmYQFTcu66VQMup9VQgOVhFJeuMJ7N6T8nM/wC3uoWQ5RsPjBBAVNvv+UG3T3KKQ/3OUnhbXJyUuHV2pe5FAVmL5dEgos7G3R/HlI5bq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DpRgn0V1; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DpRgn0V1"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5ba429b64c5so5709e87.1
        for <kvm@vger.kernel.org>; Wed, 07 Oct 2026 04:19:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791371958; cv=none;
        d=google.com; s=arc-20260327;
        b=mdQhCo7Pfkv8miscrFarwmQq6iryJ9P29LmzSQEmsqmFwSjJ25HUBN3eAHdyC4aCSp
         0+HFiSlJL3NFd3BfUlh5TZS/pwseQKzISd4npb7Te/lCPHXT9T15UPYm0VxoVULCWBKc
         Sdo/CUCyGQYI/Rq0orlmrX5H6NjJY5yeOBQUaBJQhU8D7tUW3X0ZbpfeEeU8A5RX+ieX
         x1r2U/pr2L5qieHOfudUatLJkb7c545kQUK2TxjXfcOCRKrdDMZyELO7KoD5PHpYGfcm
         vzg0ifFJewfg1h9aE/7BMJtcvcSL2o9RHnJbDVZHtDw/JX621hoStZj4680fu213QnBO
         IE8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=VTU69CrXg+oUNUa21qt+heVePxURpvvJ4P7YR2kHJSA=;
        fh=rnIkUf6r+pm8oCQPQDOHPhdYLJEIYxB5Eh3hMNjkNs4=;
        b=XbDSlrL6XOUDU2Kv8QEG6Q6ruYXevqIaVA4bghEjRTMqumFxVaO0D7VTdxWb/yAvHR
         jv+14FElcjtohl4PIHoz7YeQ5A1QdcNixpziuncpA7hB9+1dOhFeqte8A9tAQu+OhrVn
         I+LDUqJ+MSGRrcRa79TDpQDN0KNPMSl57XxxwQc0ECgrfrC55N3xz63Swh1vusedMSGJ
         f2efcp4Wys2RZ1Nj5zNDsd5sc6Wr1cFmCqx/b7IbfrrWMOqqJeZu5yaAQBF++t8a6+j8
         rvDzRc5xjS9sBVhsI+viakt+2SHu1qFk70W1OvQ7A35demUam3XwIMo7iepwkUlRTdP6
         Qg/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791371958; x=1791976758; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VTU69CrXg+oUNUa21qt+heVePxURpvvJ4P7YR2kHJSA=;
        b=DpRgn0V1s1FthXMIz63iv3oOwv/6JhUbfeL8pkj4U+ztGpS4Eq1GtUBwS445fkl4ek
         G9kssNPnw0vBzfj/Y1bO96Q97IeoZssfSHT6MCODvpFz2YR+qg9+DTC5XDrIdtw8Moig
         16bF9Qj+yUFMdhnY5nhjAEt3JylLeRtNLPUxeKFcl5/1EItudhyEu8f/A2LdZ5a/McGZ
         I3jJZprD8adogvSWJjg46niXLj6F44XsCpzARqNQ3o2LjdAmosI1z9OxGBWuNfDpMSMw
         X5rYdK67h82CvVIg3WlqA4JF86kLeFfvNmX9+s+z1jt7Q0hQXct2+SWzCcJfW5+K7YEm
         TgNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791371958; x=1791976758;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VTU69CrXg+oUNUa21qt+heVePxURpvvJ4P7YR2kHJSA=;
        b=no90Xj+VIBEa9FLQa0mQO16ek6BsWf7DlTc0YYYBIdWqeCTTAGE/tUDl69QmkKAazZ
         dwxoQB6JlkgENsFI3eWPtMA35EMG+wWYp9He5CbZfJ5JYHpKObovTD1B8bhKD89zR66c
         u+1YBTKdD8WQ9czZno5S7vx8BjRUaWMM0UzbdDa2btaCub/k+BvludQgiBQe9Gw8CdMX
         y0zQV1gWknGuajBeC4fvRc/XFTVJj/xgdJATiH7IhHVdzG3w2EImE5WAeT+4HAVDLDxX
         vvHWb/x5L2AEQ4kv2oZTluHdAQX03NqxufNAG66nkns9m+KkeZsOp7zzGMbKgE/12Nmx
         rGXw==
X-Gm-Message-State: AFq9FYI2qQddyR2rEwN/c5cal9BSfwYrbv1qN1CilLrg6M/S87N8cx8c
	yvpDeNMDbrH3cLJ4nptqiRDsqkRHBOhn7fvt0Zx5ilrIvahr3lOGb/F/ev/SVylCrc0Dxc6MdcE
	Qv7K4EGncDC0iG7V7g2CtYFpPBDE/WhjpfKPpG1Fd
X-Gm-Gg: AYBFou1cNmAciKUiF9RnATITpFF23YXbdE6kq3BgsxX9mTz1ViBNStR0abI2/0qz9Qp
	X1Q149a1k51VcMvr8PbzQXC1gwUym/MIySAoddcQBN2XiL/vAhKU/aokZwub+PT/Mg7h7jwRoUB
	pYnYW94rloHreT7Y0kzvbUCvKO/HgeSTXVyQ7+++7kJ/fN/3NP4jRAHLu/pDSQss6nUAIEblMB5
	byT1s4ZWCvaVWuYG/aDvEkHL19I8hIkaclcAtXoZZNv8lH6rMZSwW8WWfnShJSpHDHE7KRXwGmP
	CKhlhTlh5yo2a+D1KHbnp2pVmZ2nBR6wcolKcI00WzCSQ12EYCuizQ==
X-Received: by 2002:a05:6512:1385:b0:5b8:e262:d32e with SMTP id
 2adb3069b0e04-5bcca7ec141mr318055e87.1.1791371957703; Wed, 07 Oct 2026
 04:19:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007073537.2454351-1-suzuki.poulose@arm.com> <20261007073537.2454351-9-suzuki.poulose@arm.com>
In-Reply-To: <20261007073537.2454351-9-suzuki.poulose@arm.com>
From: Fuad Tabba <tabba@google.com>
Date: Wed, 7 Oct 2026 13:18:40 +0200
X-Gm-Features: AclHuK9FLvM3LbOukRQncRzEinU8YnpJHc3NQvReH44DvOmDcByJyESZjTaqDmQ
Message-ID: <CA+EHjTzV29F+MoKAKum1rUS8ZBd2j2w28yQWfHL4ymfJnVzG=A@mail.gmail.com>
Subject: Re: [PATCH v23 08/14] KVM: arm64: Add vcpu load/put call backs for flavors
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

On Wed, 7 Oct 2026 at 09:36, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> Add VM flavor specific handlers for VCPU load/put, in an effort to make it
> easier to follow the code. pauth traps were removed from VMs running PKVM
> as it is a no-op for them.
>
> Based on a patch by Marc Zyngier
>
> Suggested-by: Marc Zyngier <maz@kernel.org>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Tested-by: Gavin Shan <gshan@redhat.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>

Cheers,
/fuad
