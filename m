Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C22286A4
	for <kvm@vger.kernel.org>; Wed, 25 Mar 2026 06:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774421314; cv=none; b=HMkQ8UbD7A0XHuqGbytXMogenhQKe0e6zSKYAQgxZXacJrZTiTDIAC3pfHcqu3MajSKzpRX49GuOuznKeFpviq3sJNqLnAFnihCkzCpJ5e857+dJZkY91zsoWNsOTiKql9R7SggypGZ4jDpLTGyC3WNpdrvDkuz6GZHgPhwHIps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774421314; c=relaxed/simple;
	bh=xnkCfO5Irs/kIcpVkFyoCWxP8L8MBEjlFsyLhNx7yuw=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oUhlVITjnu7fnyakgcONTnFurZxfvEzJW/VWj1wVV43qkc0Nhj1SW7LBBlFi1G63mFRiLfAOM3aMGEHk4awBtVglzv/Udhc7qK1nW07ywNzD7ErdSK6nxAH97FOouYuePZuY0io7rpPBRe59JncmqB3QkpNBMyco3NQOomT/SRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TRspwVoM; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRspwVoM"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2ad9f316d68so11868005ad.2
        for <kvm@vger.kernel.org>; Tue, 24 Mar 2026 23:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774421313; x=1775026113; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:to:from:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xnkCfO5Irs/kIcpVkFyoCWxP8L8MBEjlFsyLhNx7yuw=;
        b=TRspwVoMtGYR6UtqTXybBl7Yf+oMavWjlMg0Dp8w8TURHhszsKOMgaWQrV54wbiDB/
         zs3JJFnQBpAyXNPmr/KXXJBxZTU5BwGRoKCrPqZehlEuSdrfBzL3l93ecHiyss78jmFc
         QavKawEHFMiDKeKZ3AmEBrsXqR8rUV9oS6nAbwj1znkmupu0izPETAlE9LlxQRMXFzhf
         kaS8+dhmv9VdPOb2J5ct2gnqDRBOmpgJ6ScoWwsFQ4ZgXf36nuKw7dqFr5EyeOsxqwmm
         TuSdBprrh/OCGIYhjd4ZPZKT+cbQTkup1tbxS6sqNOJtc6afOvQ42omZ/uW8OKsF8/ov
         hivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774421313; x=1775026113;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:to:from:date:message-id:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xnkCfO5Irs/kIcpVkFyoCWxP8L8MBEjlFsyLhNx7yuw=;
        b=fyXR4niKSaIFzIIAGOPBXhz3XMVrjTQVovt3LBaT6XWk8dzOy8qGKORdu3q7luTJsc
         cucRKmZmqLzNK9p+9lpilg654HWXTIveu1AJGpth1f9hq9do5q+2v28nFf1RnKx3DemF
         XNn6Hjkc5shI7gsXBfpgbbPW/ngzOz7crDiCJonxHBYg41R7a0Lbi0In2ILzJwbBEcE6
         G8MiRD8jQgtjjOG/aUIwmlI6Eb8LGvwOT0xXOYgnAhrv9mF059Zg4bXmnAhp2WuW1pnF
         jqPV+XfUhm8liHHqJPPlSPWlqsrgc/xgQYuKhMOAsOurADil1loYj6KqVOwRlSDUT0SO
         Kaew==
X-Gm-Message-State: AOJu0Yy4rxv14GjtXuFrbid9wrI8grPx3gqxRqNat9zs2KFx5AXnXIeb
	r8RKNYnhyf+88y8MWVYU/D3H2KfvDzy3iYf8Ij2XkwGPFbghEuuXWo/pzUfKpQHWwv9X5Q==
X-Gm-Gg: ATEYQzwgmAQC9gkGNzpJ1ib666U72aYQC1WfGDmQCRCeigc/EoHMmk2O1d/H6H4puCr
	otAyRtvx0KcHMy0oOCgJt3f53KHPcD6/+MC8aUHB5mXL1/qj8trU/EyPHGyg+xuXN76gqj9VTIf
	QD5c/It/tvAIEipTN82ca9pSaxChmPibb6qRrfPLvvQ2FENmkLs0ljNl34v1a4D7AHEqdwzLnmc
	5fX0n8aSfTKNL6BaBJAHIvbm5XnNYpO7QO+6/MgWBmJ/bHaNws8zEuWBnRCfs1Y1DPEShZyJqO/
	wtNnMAxQwLht6AnP44WAiaWiQ+biBAQunm0839M0P2RehZvbsManAKWSpoPYClawQmSuuQY1c2G
	vErMnkFndxViVi94MCUED673D8z3XtgUSPzrXJ/O6LhHMXcGQ1Ce9XHHqi+s592xpTDRzXNkKnX
	ojAo8Xkz28Jl34sPetcvIz
X-Received: by 2002:a17:903:2a8b:b0:2b0:afad:7aad with SMTP id d9443c01a7336-2b0b0ae96d9mr27011215ad.45.1774421312712;
        Tue, 24 Mar 2026 23:48:32 -0700 (PDT)
Received: from [127.0.1.1] ([112.28.134.53])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0aefd07c2sm27134525ad.31.2026.03.24.23.48.30
        for <kvm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 23:48:32 -0700 (PDT)
Message-ID: <69c38540.170a0220.5a8fb.d7f0@mx.google.com>
Date: Tue, 24 Mar 2026 23:48:32 -0700 (PDT)
From: vince <liuwf0302@gmail.com>
To: kvm@vger.kernel.org
Subject:
 Re: [PATCH kvmtool 0/2] Add GDB stub and step-debug support for x86 and arm64
In-Reply-To: <20260318154156.2064989-1-liuwf0302@gmail.com>
References: <20260318154156.2064989-1-liuwf0302@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

Gentle ping for this series.

The series adds built-in GDB remote stub and step-debug support for
kvmtool on x86 and arm64, plus documentation and a basic x86 smoke test.

I'd appreciate any comments or review feedback when time permits.

Thanks,
vince
