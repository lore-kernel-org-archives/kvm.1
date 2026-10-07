Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6DB4A0907
	for <kvm@vger.kernel.org>; Wed,  7 Oct 2026 11:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791373156; cv=pass; b=bnTryAY/JvIieW3UTU7cQRJ7iPU7p38sVLKa7v3odKaHqDNF2FpQtOLFl4PabSJTP6b2tm4qepiCNzRwzDKLCK8MP2QSNw/xasCF8R7ZeZpLlulWErIM6l2oBSF/n9c49qEBAOA6Yzl/3vXYQy5iW1KIVNuo2OdFjzZLShbv6qc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791373156; c=relaxed/simple;
	bh=x3BovMqKPyOzodOG6cYU5vpG492YG/WZZeesFshGEqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=csRdiS/OV8TCADRLqYPeWGDLq/BF53NjXMVDhOqopbtSxq/RbIh+dPk8mE7OTOUABASjwgDpbpfbR7V1h8JCeh5UF/a5rrDct5spyUWXiO/5y9EDJtO5dHO/7fO+62wEagI3nCK4I9l9OBsYnTG89kyCsHeA/3On8x65VGGFmkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MEZP69ez; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MEZP69ez"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5bcbb378fc9so8156e87.0
        for <kvm@vger.kernel.org>; Wed, 07 Oct 2026 04:38:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791373124; cv=none;
        d=google.com; s=arc-20260327;
        b=d7i3WLdKIPpua5yHIcDoICVoujBr7uZc6GiUpHd/v44mZo/i6kcIAle+mfCGHOs4JT
         znPFQ2t+3fIIs/q9abVybO+1ebkSnkTu3903Vy8I3RAuVx0ANhAp/zJv3FtHSUfFjDSd
         +YtBWJNzaVvpp2nhbwhIsl3wTNKmGXdtfXhcR3zI4iOKnAIUZ1/kisJvhwsXCiLPRRSY
         I6xf8w7fwf3+fMjidHE9jGlhDB+H0no2agSYelhX2j97/SlEKSr1DT0F/yaBzxc4+qAA
         E5NW1PkmdSJ+CuOmTIKPDq1UDxPJhMuG2YAFrG3RE3HbGAIMt3cS8yXriSw3L9ohk+ld
         pPwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=x3BovMqKPyOzodOG6cYU5vpG492YG/WZZeesFshGEqQ=;
        fh=rnIkUf6r+pm8oCQPQDOHPhdYLJEIYxB5Eh3hMNjkNs4=;
        b=BXpRU1We4C3wy8lJY1Otfu2hCMg2k35JK2Hs0v1UPMIYltMphRQqPH8e6c6M39zjCJ
         eFcnWB/PuXh9eIFdDu30DOawxhdTlOF0wu+FhowKx21feajhFfVtr8872Fp65bDuUPbQ
         txcJPZqz0IOIm9U+KISX2oX9vvDJcyuKK89yNskPcXPLU433wK3Onua2yEkN9aL6y2Oe
         SE6q18o0GqHrRcdVGdgXMioQmsT/ie4w8jFRP3V9i6OnRbfSM5n+LcMQNJhtKhY4CTdG
         jF9Io55U7x++tTyjmRyVU1YDHBmMY7lk3SLNu2rLivUndP/IhzeHKvaN1yaZPLcPBE3D
         eQ8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791373124; x=1791977924; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x3BovMqKPyOzodOG6cYU5vpG492YG/WZZeesFshGEqQ=;
        b=MEZP69ez2h6cMP8KVq+rwlyqfNMmHJTjAavsHtqjjy4k/nQn1muG1v1HOYvTK8y8pe
         OCR3gyq9Wpx+iuWjntOv7nIBQQaRnY+boMSyA5XyvXE8fKDriOFdBfgU2AStu3VXqFED
         /dgzzAQ/YY5Cfta5/scySW4ylbZX++Oq5uRX3n2/adqph6ZtWX5rQmzdKk/VRlpjqKn7
         gTx6OVb9cqxxWHDsy5zOg4/6Bn3c4NrNiIp6n0Pzn/4q8SGMV2nd9Pwem5t+1uO0kd27
         bWMlsd37YQjzUQs60/tN5Lz7OXUC+uUCVHueBXzcIEMqODmaqIEWDkNsvrwNtlYlK3ID
         +G3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791373124; x=1791977924;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=x3BovMqKPyOzodOG6cYU5vpG492YG/WZZeesFshGEqQ=;
        b=E6h4L+L2GXApoM1bNmW+nCEO/j7eKzadLzUUbVVDkwORH5GPGQ7XnVB0jjSITMf3El
         rWuhC1Zycc4i6HtCsio+CkWVFZFEMjGbtKtHTIGIHXzpZLNmJN2enG9Yp1/F8RFmCzAV
         ZbJhQcuX4FOeRtpyW2plohrI/Jx6zkpOlmV9bPKdQozA7eDZrsgpEo6HUeeCScKqM2Ig
         DU9pFFqJh3s4TjLPhURYd2fE0koZ7gujc7trkTrD1lrQ2LsbdadMqIVR9Ik39Qqg+DPj
         n6NgefjYM1XGSKzZQ3MRLVL0mOs0Jab4Ypm5HJZZbrimwaqqK83vs61kDv0V/bCXalmM
         ipxQ==
X-Gm-Message-State: AFq9FYKFg13fiV/Lj2/m4epUdMTeVPj4bhpmEdMuM0m77GxL8JkhWeVt
	xMe8VXgvzTbO2rUFbLb3zSszc/opTs3L68pj3rYBU5YaGQmwfzJ7xGDAIBtKO2r6dw7fkDvjKxa
	8aovCeiSsgN2OBsHe89XwBQIg1UWDox0T3de9T/3L
X-Gm-Gg: AYBFou0bKs+zCDv3mY9pmMrewMLm5aOKa9pHKSvCZu2HbOGDwgOciJIDkOx4h4LkTfm
	R0iIDwjxOKJmeFN+yZwjancTTPOahpzkXl/oU0zt2mrWS5A2NEwvxt22AdgGH6S15ufwzx0InRH
	8P+/T28hvnWPKujgHB/t6nlfnq8Yv6b/acUuWuTlcdY1RVKXbEGxD0v0v2f5XdeJoWuqMoC0zFm
	zu0/gVodblfh9DUdeQytRIjVS5w/0ABOUQCvdgQ690GPjJ76chxynIe6RTVEEpEg2jiKm53JY1f
	C3rwM2Ap39C8wbNvmaDusXSbxLHwurowZmA9bi3Fc083q7rY2XKzswO7kDdB72tF
X-Received: by 2002:a05:6512:3f0d:b0:5ae:cf5f:4a88 with SMTP id
 2adb3069b0e04-5bcca857470mr322236e87.8.1791373123590; Wed, 07 Oct 2026
 04:38:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007073537.2454351-1-suzuki.poulose@arm.com> <20261007073537.2454351-11-suzuki.poulose@arm.com>
In-Reply-To: <20261007073537.2454351-11-suzuki.poulose@arm.com>
From: Fuad Tabba <tabba@google.com>
Date: Wed, 7 Oct 2026 13:38:06 +0200
X-Gm-Features: AclHuK-THf1WIqt3xPRpWJs1Q81-pzVnFszT4A1vRUwtheoFlxrVY7-HpfrRH5U
Message-ID: <CA+EHjTx=CoD5vUN7X6VcuoLeoqXeF_h_JVuhiwaHLBqNraZg8A@mail.gmail.com>
Subject: Re: [PATCH v23 10/14] KVM: arm64: Add VM specific callback for S2 MMU operations
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
> Add VM type specific S2 MMU operation backends which can be initialized per
> VM flavor, to keep the handling cleaner.
>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>

Cheers,
/fuad
