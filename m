Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE4B37A827
	for <kvm@vger.kernel.org>; Mon, 14 Sep 2026 05:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789362395; cv=none; b=li5Kuo0G+E8eJIFcbR3DMlm8kt0M8UIXfDQbJ1K0cNqKZf7Il2g+vikbtOsA1KHPVJbY04QESIHMwxO/PJBj+Qk4vbZ3B0zNuSkMcEoBPxFZdmVn2tvnE6CnadAaKP+TEgsqjJKxXgdwagv8sWrKzBpIIIEy3pyrmIQxuoNXlX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789362395; c=relaxed/simple;
	bh=E9cc/135TTwNgjmAOrXJSDfGY3OksbkbWgtTU95PGtw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nlcxmAZKWCEiqdbqbeG1plqslwQu1DXJ+27XNj7GGSxWkyHYXnTYf5Lp7W/wEYCKRxxX06MP3TCcylKIGDMrNz5+9xs5sKP+tiGWiUeIAQSwfIqg+e2iQNSjwx4c0FE/C0mWuQHBSp0uZkDWBv6gfvazlMsDKg3LfuRMPBsKAG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BJEt1Jmp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jONv2xl3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BJEt1Jmp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jONv2xl3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789362392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CTGrNcFkd0r7wvxM+LayJdDhB/Bf4MUfRoY837NnKYo=;
	b=BJEt1JmpXP5HajgyfS0nzT5tA38UGP/ujuQ8xwXwelDEEJBwZBV0O2xpgNj7vuUGtGjWXl
	4F6DygIBKSTWq5Rtp5HSmhMphpnyTU1FwQQ32bsF9SW+YX+ZiRjt873vRq5nbTngwLLxzg
	ioyHdpJ6n+Avt4x7hXkFgGbUzm/Y1CE=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-ZeNX3QVSMOmODpbCG8g-3w-1; Mon, 14 Sep 2026 01:06:30 -0400
X-MC-Unique: ZeNX3QVSMOmODpbCG8g-3w-1
X-Mimecast-MFC-AGG-ID: ZeNX3QVSMOmODpbCG8g-3w_1789362389
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc4e496e5c3so827142a12.0
        for <kvm@vger.kernel.org>; Sun, 13 Sep 2026 22:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789362389; x=1789967189; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CTGrNcFkd0r7wvxM+LayJdDhB/Bf4MUfRoY837NnKYo=;
        b=jONv2xl35EG2/+qy0VdG3Q/3pfknoJI6h2Sh6K+TjGumlrdNc/oe/ryUIbSioqvm3a
         ukZIuXlEtHDAw/yf1JAa4zgsHCkUt4NPiUXl9ti+EqZU4qlUmrRVuCIS57le6C5k6bx6
         d6ywc2fcqOZoNMWJy2PSI13c8a7h4HbFYEIaQcBRKBTifiuuVAmlV8Q/VSoJDLrgVLcq
         9CTsY0kEJloK3smmaWxFHg/CVnTfzktQxT2xfZdtzioeKLwoRrQmTT78CARSRq/MKwdL
         UD4qBtnXDmw0efmmecXIC5ac897s20/3VpwJao6HgY7gRKD7CG+zSxI4IKb27ZmPE0Es
         B9gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789362389; x=1789967189;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CTGrNcFkd0r7wvxM+LayJdDhB/Bf4MUfRoY837NnKYo=;
        b=c9zeS328AQiR2DIrkHLZOL2W1d1tcXkRvQIHdnRg8dlCSSd2ogMA2KfIVLbnBf78PR
         si9NITv11vNtwq0l7I3OLZVs8pw1pUkpq02hzZwOU1VXh1bG56maeDyqyLq8c+SJ3KMD
         F3zIDgPaGm5fDNIS3g0nwRWUJz57HeBvlp2sZ8SMF4w0BAsv6NH4DD0lCVkcl+sX4ZBM
         APnJZ/2GeJCKNe1jO8Caa0uBS5jYWNzUQIjEuDZwpp5vQjmVpc/xZz9OJtrfpd7vjczW
         iRuTiy19sES78GSG6+hBInnYmNukimpMv80W1niwPeUdmkwo8Vh2NlGuotDLhPRxD/St
         kjyA==
X-Forwarded-Encrypted: i=1; AKwUvBxuoEWSxsZ3CRDjLtOn+vMT1MBdUOlQQcesqNHtSzvD+i0Qwgfyth/H26+aECdfSCx6QrQ=@vger.kernel.org
X-Gm-Message-State: AFuF++k0BJi0EmloCCSDRJmMcBOZk3afbRgpHa1LOekfzXN/nu/seFhZ
	MzIA/PbPM1AGnMNLOQQboV3SIyqBR+a48RuRV1c+X+dGY3ny4vxf1fr1MMdOd8RbvqEXiNOmW5K
	yNqJhaRa3sBS7BIdPyS25h+undJpdrLcx0XT8nM9ikzMcQkIrSilm5A==
X-Gm-Gg: AYBFou0moH8NW/J2GMw6cK7TmVWt/DvphmkkkbPD0P+EuRX3FbliD4EWL5z6Hw90l40
	IcgOQpZiQn8NslkTR4DM6BxKN2DXJjRDTj6REOa+B/xavnjp3SjHKDc1+BKcM/5fo2mPjQyyXuk
	X3JjITnJ5hGBDdENgmd83IbLB1IfpA6Ynw/s435gg3TGEyAHYXlGvrXBwOeCp9bfRlGe0eA5VxW
	vJf6EAEICesHOoIAhVja9aOKnI4F3nGiTgEzx7g20LbA+jgw+Z2ijNHInptdGATI+SHn0J1MLMC
	cE+EM0pARJtuvLXb6NnNVCx1ouPstTXNIA3xp1f2p10vzt3z6wV230JvMTk9IDuLlH5XO/d5lqd
	MPlz5omFnSf21/Cmt5iCguixwS6skSAujlNJrFOtHeg==
X-Received: by 2002:a05:6a20:7290:b0:3d1:2dc5:7d37 with SMTP id adf61e73a8af0-3db4039c82cmr2007614637.3.1789362388808;
        Sun, 13 Sep 2026 22:06:28 -0700 (PDT)
X-Received: by 2002:a05:6a20:7290:b0:3d1:2dc5:7d37 with SMTP id adf61e73a8af0-3db4039c82cmr2007526637.3.1789362388369;
        Sun, 13 Sep 2026 22:06:28 -0700 (PDT)
Received: from [192.168.68.52] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc4c654b5b0sm4167221a12.13.2026.09.13.22.06.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Sep 2026 22:06:27 -0700 (PDT)
Message-ID: <e15dff15-74d5-459c-98ed-0473a7761c69@redhat.com>
Date: Mon, 14 Sep 2026 15:06:15 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 5/7] firmware: arm_rmm: Activate the RMM
To: Suzuki K Poulose <suzuki.poulose@arm.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev
Cc: maz@kernel.org, will@kernel.org, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 steven.price@arm.com, aneesh.kumar@kernel.org, oupton@kernel.org,
 joey.gouly@arm.com, tabba@google.com, yuzenghui@huawei.com,
 linux-coco@lists.linux.dev, gankulkarni@os.amperecomputing.com,
 sdonthineni@nvidia.com, alpergun@google.com, fj0570is@fujitsu.com,
 WeiLin.Chang@arm.com, lpieralisi@kernel.org, enju.kohei@fujitsu.com
References: <20260912083611.2513845-1-suzuki.poulose@arm.com>
 <20260912083611.2513845-6-suzuki.poulose@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260912083611.2513845-6-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/12/26 6:36 PM, Suzuki K Poulose wrote:
> From: Steven Price <steven.price@arm.com>
> 
> Activate the RMM after the basic configuration. This is a memory transferring,
> stateful operation.
> 
> Signed-off-by: Steven Price <steven.price@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Changes since v17:
>   * Inline RMM_ACTIVATE command and remove the definitions from arm-rmi-cmds.h
>   * Use scope-based cleanup to free sro object
> Changes since v16:
>   * Split into a new patch
> ---
>   drivers/firmware/arm_rmm/rmi.c | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>

