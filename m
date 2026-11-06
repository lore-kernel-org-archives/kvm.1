Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794000031;
	b=rjGd2UoOU/HmBCHk8kjR+geS0gS4TXUPkaoZUU0PYLrYP+6a3HaX4urlq+a5EW3oeBoY
	 yoFY8wtJ8wof9R+W5RhrBZIAOnANLqfuhmveSPeftaZJA4E+GryiT0/xCscLZZTH15sFi
	 cqF/wo8BPC7BI8n25wx+OLki3iBZpvsF2CVqX1aIWyiEpQl6BlOZpsG7iPqGi50XhWJUd
	 FONCbiRp+vofsNheYeBto0sg4SbXk3NHwINoLEtHJ5o6T5MENkuNYQedRPHNl5FfIXtwP
	 2dOAUj7MUhvzvk4TEcF/YzzWcyJWFgENsk0JkcwliXG2SymyHLcIKaaIGHU04Yf+4zg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794000031;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=dEASJP8cPGURwGTSZkAlcNwWe8/bY8nmtMI6AXQzVBA=;
	b=ffOBKzI4U8AQzWzCIgGV4jGNBj1/QQptdcmw4f3j9FLcJ7qg1TX+HcyKBM65Q3/DepQA
	 J5HjcjKl6TBO0rkExo2RFhbcZxgZ7cddPwu75SBNXZqdGrAmMnbX7ZiPJIZaNkyqLy9tX
	 igNg2OY1XPSL7LfKuN8DmTK4uGp1G1E/2oAbGdQSuQFxBxXrUSe8NweTPD36s4a88cHsK
	 BAMenJppxH1bW1Lp2SL4L2AQoC+X75bhEkZ756Qq0qswVvW+kILC/GcJt3OX5DIek8ngr
	 EnQerspHEPP8yasha+m+Vg2829DTMA+O5SQbtM8rEAauwEyiVgq38r9f2AWIF5nzKUw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZJqjhSH7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2F4606A326
	for <kvm@vger.kernel.org>; Fri,  6 Nov 2026 21:20:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA2F4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZJqjhSH7
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b571a45a2aso1831a12.0
        for <kvm@vger.kernel.org>; Fri, 06 Nov 2026 13:20:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794000029; cv=none;
        d=google.com; s=arc-20260327;
        b=Z1u220zmcZpsqtOWl+6B9PmgCYtBXR5UGJKu7Y7sXV7fkJc7PMIVO01YuSUX3Yd3Zq
         rBqESIrpbH4eMFgpeRTjfBRpOhGG6xp9eF/3mNBqnm8U8E3fx6dd5wydk4WMEO2hxSG7
         kogDlfKMl5MyzGeU2HnBqzoMrR7o248buALr5zxzTvhjKbDqFmGd5q53f7gBdTUD6oZ2
         eC0HgqTht9roYCYLO9UnBvr1smtVq1oldgdY76vM8hPm1Dm8mFjqsTlPnW+F5GCKiJxS
         TnTwxOSlxbi0TI3FilPWgBkUHFpVO1QbffQHYxaW7pfRWjuEk0qD2D86NYo/m4cFUArR
         xGFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dEASJP8cPGURwGTSZkAlcNwWe8/bY8nmtMI6AXQzVBA=;
        fh=5ZFhcVM7M37xPemY9qmZk0uHGZ9Hxdwh/nCKAKKSpbY=;
        b=qV012+eckY+PerMxRgFUoHOWNP80JFZc5W9W8WXqK+ACTE8W9ixiHBrFC7SZJqUzwA
         NbsaLRdeIfpH8LDKh6la89b2A7zn0FWYAzZiOmnXlUAqKGc1mOwUkS08I3DP/z+zyyyC
         BD4k/rPyVj74PGkFDcdcJVie/6Nqg4TiIM1eM0TN/uIo4A6JmE2wfRXD1Nz2E0iWAZJD
         pWHthNtEmGMvn6l7EJsguajVRbqqTzr2rnU//9l7qSAjKT5EAbeYWLmuF5V1E1nyQY4Z
         G5Gow0kL6DDYB2R78wkuJRhAcq8445viXgrQAFt3cVPbbcEhlHMMrqy8JBLJnL0DrFvK
         O9mQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794000029; x=1794604829; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dEASJP8cPGURwGTSZkAlcNwWe8/bY8nmtMI6AXQzVBA=;
        b=ZJqjhSH7PAHxPDDqpUN6vGJkc/0roGheqDnG5neNfKgE0s8l9/n5zOViHpddfjKA/1
         NN7YnadMOedcZG8vo55+RpGBZMzq5Zvm/M41dmNJ8Elat7NJQKd0Vnsomh3uq8q/uaQk
         eFibAh1LGHNxgvGe7PJpF7Tk24Z4zJkTRb6Ajy4CGVebcUeHg6vnkZ3ul0RpL7+Bc/G6
         baZcu+nU2GpHmn93DtWBLuauJUCc5dnudu0LGB4S5QYVS7Oekll5y0SFL+c1mbhKMYMx
         VGlRbqDEba9BpLMeixyeeleBiPc2VhJqdMdKYrm2VppvSrFTDx1Riu49rfHpiU3qhaKg
         fJVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794000029; x=1794604829;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dEASJP8cPGURwGTSZkAlcNwWe8/bY8nmtMI6AXQzVBA=;
        b=YJhJ1/T1wegWQ6MmeIftIrSrSMgp+2e19jPcFtl/71oNjJBTUosaLfsiwoButQzeOV
         HSY9SRy8kpEQfVDsttx+Mw6ceqLNvPaKNaDHMwcxAPhuIEydOw86oLejgPsbJ40yDZ59
         +vHghNk8LyXLzS3Uakan6aZy9i4hXzU1ifhc3S86DJyHohslaZZNwNHqJOGlcD+0qpjL
         oLRpL91obyaI4SPQ4sr/pDn17mCeVdFs39LXNfMpq1/blDzBGLLOOnguKyg456gNoOkJ
         TBIPe/fb8FL0XJ0kfitia9vbySPVEFoMIB5jJ8KLqe1wnCQY4wY/kjKdXqwafq2Xb2ql
         kFMQ==
X-Forwarded-Encrypted: i=1; AL+hErEg0DhEetxyB+XnCyEyaZanhbDQ0mywhtfDHSnGpEx/1A7GIuilqzOkmcKieJOKte9G190=@vger.kernel.org
X-Gm-Message-State: APuU4Z9VOpKPpSse93nggis1iQMAN1eYkSSVvEZIDIr0rIPpuYZhPVY5
	9HsIYyWTmVvU+4SiWgR4Qy6gz2PkCWPHe4p+qWQIGYn9Ey4N03/Q7EfiHM40RAn71h4NkPrhsc4
	4D/v/WIhafk50FHtI9kplFULj/0ahEK1jCB4WydkupqgTYk506ckFHwxpOjA=
X-Gm-Gg: AYBFou1sFmbYPEwqy7RImQozGVhOCuU9XJRue+qWuocl8PZdfWr1pGuZcJ1WsvMGtYx
	H5jj1NrQ7P6fFkvd+Elj9U3ql24h9Ne33IiHCkAfZtLx++gxVCIc5ZkwPdEfJb/zmEpioE2vuTX
	w9fHLwTnyIDnbrMQkMJz1BALt/fDpZXLtizab7I/aLrpPuPnBHXwNqKasdWPTz1BeLCo9W7MxCj
	xbjToI4vTS29XhOMk1I7t20eqymD2dZ6qo0LBrzwZ9P4lt1ff1c0b02Pm9QB9xxBjo0ilN08XUF
	pAB/RD+2gRiX+DMAT5Kqq3zW4EdANmHkVGgrWpOxdmOCiKLbKRmiqEi0X48vxCLOV0FYf6pyNJ6
	ZG/7v9JVxQVGA+eS6MgVJQVR2kzD3VKc1skKC0YVx9rTrLVTUJp61TqSJ+Fp3sxFjiguHlxuI
X-Received: by 2002:a05:6402:8da:b0:6b5:77a4:e7c9 with SMTP id
 4fb4d7f45d1cf-6b6fa3c759bmr8754a12.2.1794000028655; Fri, 06 Nov 2026 13:20:28
 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106013927.166209-1-zide.chen@intel.com> <20261106013927.166209-18-zide.chen@intel.com>
In-Reply-To: <20261106013927.166209-18-zide.chen@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 6 Nov 2026 13:20:14 -0800
X-Gm-Features: AclHuK8gDDUzygB7xOSLMvBuJupD6Lp3-Om_QG8PNIiEO_YVjCf-4zFUNn3jTVs
Message-ID: <CALMp9eRAJfDSdxi72e0JS+jGvMGEPThwfo_VF-7Fbs3EmhcGjA@mail.gmail.com>
Subject: Re: [PATCH v3 17/18] KVM: x86/pmu: Advertise PerfMon version 5 on
 Intel hosts
To: Zide Chen <zide.chen@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>, 
	Andi Kleen <ak@linux.intel.com>, Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>, 
	Shukla Manali <Manali.Shukla@amd.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 5:50=E2=80=AFPM Zide Chen <zide.chen@intel.com> wrot=
e:
>
> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> KVM currently caps the guest PerfMon version at 2 for all Intel
> platforms. Now that KVM emulates the basic architectural PMU features
> introduced in PerfMon versions 3 through 5, raise the guest PerfMon
> version to 5. Features that require additional emulation support, e.g.
> architectural LBR will be enabled separately.
>
> PerfMon versions 3 and 4 continue to be exposed as version 2 because
> KVM cannot safely virtualize AnyThread due to cross-VM information
> leakage. PerfMon v5 is supported because it provides the
> AnyThread-deprecated capability, allowing KVM to indicate that
> AnyThread is deprecated.
>
> When enable_mediated_pmu is disabled or in the non-Intel paths, KVM
> retains the existing cap of version 2.
>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
