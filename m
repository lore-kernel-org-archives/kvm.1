Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8432541760
	for <kvm@vger.kernel.org>; Sun, 19 Apr 2026 16:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776615072; cv=none; b=MYr+1GBt2LGMNuu3uFUWKIqsy9ZgWDz0dCh38UO1a0zompMX3vSL6DZrC2qbcaN20LLN9PIgHunZBivTk0AmYszr8ee1Ug4pi+IDdfcu1lbBgwwsuAK8DFjDr/ERBEZohLdwDj8fYf6Hk4/mrojv9BsaJv4atXvEcwAw9/4w6G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776615072; c=relaxed/simple;
	bh=p8NcGZRcnUej4oOdH66UTG/Z/UcILKqrfsAxpmKT3RY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rKxVkWq+023y9elwFNfsrHbSbijOi89qHYWsxs8VXSyNzOlisr3Hnkykwo05MMf+iooyjbdqd/Lr7dCMxTiaRJJb+ziB+47RMLHF8Mw+endSeD4XaEqt4MnLDRlZc6uScMAnQGAGmnexpLFchhWH/3FwO+CQd+nJhp19MeS43Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LSQCtOnP; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LSQCtOnP"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43d03db7f87so1355075f8f.3
        for <kvm@vger.kernel.org>; Sun, 19 Apr 2026 09:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776615070; x=1777219870; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xPkmu94sCymbMXXa0bHCC/HhTEmKswW/grC4BA01Idw=;
        b=LSQCtOnPVKeBsp7DSyh/U/q5i7JCVC2hJBiWJEzBbqphh991qpT7CwrEE6RUqKQMDS
         Rg7XE8v+LqbJrklDTervYgfacyuM3LMVZrBNFgdFPucDRTTw2zP7rGFtQhpN65DrpeJw
         Xmp7/TcGSJYY9p41NNGb3Tn6VnQmZjihZmLAbVI5MhUtNj0C9aptpKNTu6V0iADddRA3
         SNXc8FTKYP7YUaymy2sLfcNVgEjVoOlC41ENXh+9XAMvZ6YO0uZhexDDv5DrbJws0p+g
         HPI+Xg3aD9QJheHtn5B2Fx64y6hwET46F46rjYl8Hf/0exzBtGl7iOP3evqRJ2pNGGGL
         a52g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776615070; x=1777219870;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xPkmu94sCymbMXXa0bHCC/HhTEmKswW/grC4BA01Idw=;
        b=OT4brU9yMIF7iW8dT+D4Jk8iFua54yrvMrpVTk4Hq3wDMa1qk4muTVSBV+3iITT6uU
         V2Wj74q23AzRpBeHXNTMVbPR06fdZaobljO6ULovzZHuomaQ/DugGwSsBtNT7DurL4uU
         UtqaKx412SqrA/EU6KXrjNATX9ZraiqrJJZ+Lc4pcOIfnOfkWd2+V877Cf6EGEk5znFe
         paHxJ7Xnv7s9CO3XAmTK3v7LAq5vRBJqOGWLgn4G/vy5g4wVhntFpFPF7tuw8YciE9bm
         +qmum2S1Rj0vxPm51a/7zOvErnAeStZMc1/po2Md2nxufBoneIDhQ7Gp/RAyqXL+MiF7
         cOpg==
X-Forwarded-Encrypted: i=1; AFNElJ8UdVOYo3k+mejHx2zsywVvTCJUEGaAr+5kf/mJhgRRdeMnadFCr9+TshGwu6CpVdclQ74=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpdu76Ht/tYEQ+R1bFYWExCFrkUqKFqABGx6wzRExEDzmuUYzo
	oCejrqMGSTdxo4oiRrRxw2RrjJSMi/cFEmzZDjs5huTGZ9m2BiWJQYp9XM/oSlZvrHU=
X-Gm-Gg: AeBDievWvmi+uFqbG26oc1SsjiHO/S2RDXhXFRk7z52WSKVM27fSEmEbS/8QPyvMAMo
	gwSFWP7bF+fYzrFoJmf1JeK8FDlodyCJaZtVX2n33TFpqbhSsR4iUOPBXs5i/fZGnmaLa/RtUyo
	CQUDdchNy3wgao9NEW/1Z44fi1dyecWMQbGana3+nXHCJaMRfSAUH5NelUsAzRg+F9QvEFyDHRy
	r+j0hYRWbJYXsHrCK7Yin9wMPxnG6Bg2flyOG0siQ7xHpMnvUyCG/ULH+E6JiqUY4zCVHdpGLFS
	mb4q3zoIQtb+wgDxwfX9WxeK8ZnDLHXA16aq+kX++VVHOBbpbieNQI9ugQNXwdejIIR5AKjr0qJ
	PEFNC+5g2+MbOlKuA1EDSYjmH6hlF5ajI1dUIPlsz1HffRfBmAIbXOxhbTP4JaXIi0dMYt2XtT3
	wCa0AVsO8JhycxmB3VKaY0kFL8IfiyjLk41fZHc+OAVPE8P4AIqPhaXAi+9R3yxqdSbPnaP01sQ
	NEy
X-Received: by 2002:a5d:46ce:0:b0:43f:dd40:bbc8 with SMTP id ffacd0b85a97d-43fe3dfbd25mr10949699f8f.24.1776615069798;
        Sun, 19 Apr 2026 09:11:09 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e59f97sm24738249f8f.37.2026.04.19.09.11.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2026 09:11:09 -0700 (PDT)
Message-ID: <edd3754c-c70b-4ad4-adae-c685dd6a9e56@linaro.org>
Date: Sun, 19 Apr 2026 18:11:08 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] target/ppc: Forbid to use legacy ldst_phys() API
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>, kvm@vger.kernel.org,
 qemu-ppc@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260319111936.68041-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260319111936.68041-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Ping?

On 19/3/26 12:19, Philippe Mathieu-Daudé wrote:
> Replace legacy ld/st_phys() by address_space_ld/st()
> then lock the target again further legacy API uses.
> 
> Philippe Mathieu-Daudé (8):
>    hw/ppc/spapr: Un-inline rtas_load/store() helpers
>    target/ppc: Factor common ppc_load_epr() helper out
>    target/ppc/mmu: Remove unused hash32_store_hpte() helpers
>    target/ppc/mmu: Restrict hash32_load_hpte() helpers scope
>    target/ppc/mmu: Replace legacy ld/st_phys() -> address_space_ld/st()
>    hw/ppc/pegasos: Introduce rtas_ldl() / rtas_stl() helpers
>    hw/ppc/pegasos: Replace legacy ld/st_phys() -> address_space_ld/st()
>    configs/targets: Restrict the legacy ldst_phys() API on PPC

