Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916973F0AA6
	for <kvm@vger.kernel.org>; Fri,  1 May 2026 19:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777662291; cv=pass; b=SHEGPLga4QRlol3HnSqKmqAG050kTQzSsjcf1qFNGO4Cu/uzuhNB422LlbvMN0MRbwL1CrdmecD2Gr32GkKP5bDHoeD3Mbc+uYeQUDjazk2iCrJiMElkmwrbkVSuwL81IVj4W7WY/6aPqIq3aoir+Q1CwAsoMMLr/txiVS9Md38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777662291; c=relaxed/simple;
	bh=bebv1clrkuxRBvZuRjd20Nlr/TDaUWZ2u175JUHDsR4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rciI89bVoU2e90jq4p8Wo2glYI3bJZNzksQ20ByscQiHbuP2lFaLsNJxMPvs8AS6H3GrZ4/cMSb6T1pqqAf38LmSj7HqXw7FdygaPn0turn6hq1OSLIe3xwTGgnWZ0Fdu2tK7mealiu3IA6NQFKMvYILabgExsXiXiPYbEkXOJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J/JgOXN8; arc=pass smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J/JgOXN8"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-628086439b6so1871824137.2
        for <kvm@vger.kernel.org>; Fri, 01 May 2026 12:04:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777662286; cv=none;
        d=google.com; s=arc-20240605;
        b=fJZO+BGHOgRbhu/fBg2fI57svhThZ3+XSy0vHa0TXmVPFgOJa4dgyYP4QNVwaB42Yy
         FdpeT0L3nZbWGCqfuRQqtPmJVnShJ1N8eFLEe9WteZErovCE1j0Ri3fFRQpjFVvyODYM
         HI/5Rd9QYy8umvuzGDruHbG8gyzGtr+zFeg69K6VzFMv6LRu0H6OgmnJr8THB+y1si2t
         bPbfOeJE9fwdMd1XJocZAqYDv4Ls7vFrf5IWEG4qN5C88kusJo8TK3D4Q3j3M+dlAiqr
         J5gwv0IwuUXCrFYV4DtedSj7jE/vIyPI9lHn54cYuqzjllWX8vahjqW86idvfXd+geYC
         iL/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=bebv1clrkuxRBvZuRjd20Nlr/TDaUWZ2u175JUHDsR4=;
        fh=/vHpC2RT69NyxV1X886UM8epdWK4Ji9hMyiIaDFvlp0=;
        b=jyLx5LQWnYhNFkGdtOCu16O3wyKa2Mzaz+p9NPaJJhe5Q+eBOMa5d3Kdp5652+r8Xn
         qUp7ncx5NNohNr2ojG1WQn+ROc61s6cXWmC6W55y/JCOVR24W+593EoniU9cm/lbp4Lw
         uEI+mw6LepCuw5wkQnf0gxKp9kRZ2UIAsXk/HBwf+0B9iKljlbQFeeMcb8ge8/teqEy4
         Gh7AOCPw2UQgBjtezkO9zBKV+rqruK5JorKQFVbKTRn/YgOGUZEIKvnfeQogfvJjU3vg
         zBrLscZhbNzd6eKbD6jpA7grRIATpFpm1CygMJEUObk6UoKaiMVMIEpfGao4SDItI9is
         boOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777662286; x=1778267086; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=bebv1clrkuxRBvZuRjd20Nlr/TDaUWZ2u175JUHDsR4=;
        b=J/JgOXN88MlABpE97FGlOeUMQ+TdHEvjppvYJWV5S1sir30FGdOmJU27djaS2KaH7U
         sTeop2sUDRwYVFi/hUaXk9Yg9bkxl63SE7++r/96IzOTUOEIa4gpa07GWkHUwoytERSj
         m/qo+HvZt9HCZSmU/LLB3sb0Qi0pVTezhmSyQcNgwBXmqVaWtR3g0MgCzK4Wek/q7MqI
         jwK9ROF8bF/WlT4uEUaubGn9CV0aLgN+k7nRXEpO5NbgcB12lHVAD4YnVUL86PZurl9y
         X99YkWS9fFD0yjaGMQPnZOdDRzxCCCrvxesq99n/FYfgAkG/0+aRM4Dz8020v/ZED460
         LEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777662286; x=1778267086;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bebv1clrkuxRBvZuRjd20Nlr/TDaUWZ2u175JUHDsR4=;
        b=mx1fq++oPKkb+AINIRn3hdUbZnrSKdZTXI2xQx8/DKBxnnQJV65A+MH3EQ9fHO9u6f
         c5N110PW+KH7D8v7FNN7YLPE3krOG3xm7q+HXuD9abDPaqn2ZYtz2MROSnmtczEzP3uE
         TVcsyRNa5e31QiCEv8LaDRIU4HS8B7uVEYiAROCz/lgV4pqZKdqGzw3fJyMAQpS1VtMT
         iK2zf3YIquLsYO5hN7nCk3W/ZTl6cNLslnaWrWsXmGhHhJD3xc+WkUcRwM7tjaskPPfq
         jAOIun6FA9iWcSXzpRrYt2tlslkmpYId+JxAEke1lUu2zzR0xVLuqioOlzl0pT68Vy6C
         x9YA==
X-Forwarded-Encrypted: i=1; AFNElJ/UMWnkqWR88HJqBY7YKdNuxWOaoJJhhr5BX6e5h/zH+2C6Cihi12Id9l3Y4jqKZrPIi60=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRpsxzll9UjBmaLjzYifq1sD0kzrhTTKhGOy5+By1RYx60gt0C
	IW2gv2ZMjpYp3tZdkabK9//KYWJgPB01WiUi41kKqAygiQFmasc7MwYx+jEM3mkjAT617O8oPXV
	1aNyeP2tdT2OGxiYL4pfMT1fWIi+yy9vMRKecXOdW
X-Gm-Gg: AeBDieuLVDuTlAytSh6jiaimBPt7zEXRn1wNS81TmtX4l7ENskkt3nqcI+RbPa3jSmp
	UZ3YN2WCohP5Ku/0N6pwRg0lP5LKJUBjCKbp0Ng1XMYq/4TXMBbpdqlhOjwlD7CT6nGaZ7lx4C5
	xswOxyhUSVRkkV2IqS9Fo+rxQLeyr8XOKxw2cGGvj0UBbxJyhOL8qdfF1LCfDXwxHGsrxQk+UV9
	5IeeGuPEwH9bmpTppBfEp+rSz1+AGYmWauDcOk8Stj5WZsX/xIDT6ibfVkqrZSfPfypyVrVnGzH
	tScMd7PQD+b/Q3N3qAwe//fX4KeFPJlpJdZ95XlyiG+jDhpADDbNdo+rgAzgg1ryoe0OJukSKY2
	KmGBj+l/hkLW15ZA=
X-Received: by 2002:a05:6102:808d:b0:618:3503:5659 with SMTP id
 ada2fe7eead31-62d86a1cf6amr417508137.14.1777662286010; Fri, 01 May 2026
 12:04:46 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 1 May 2026 12:04:45 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 1 May 2026 12:04:45 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <112cc1213834de1ac97c71314a565ba7dc4af30b.1775874970.git.ashish.kalra@amd.com>
References: <cover.1775874970.git.ashish.kalra@amd.com> <112cc1213834de1ac97c71314a565ba7dc4af30b.1775874970.git.ashish.kalra@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 1 May 2026 12:04:45 -0700
X-Gm-Features: AVHnY4JWJ3U3t-qQAMoWKtwBg2sRUlPP1ctl-P2SiKHJIBgo7x_W8ikUl9ZrtSs
Message-ID: <CAEvNRgFVB_-i86RTanqLEeJDHujRXnKo6OnQXduPCwKz8So_kQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] x86/sev: Add interface to re-enable RMP optimizations.
To: Ashish Kalra <Ashish.Kalra@amd.com>, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, seanjc@google.com, 
	peterz@infradead.org, thomas.lendacky@amd.com, herbert@gondor.apana.org.au, 
	davem@davemloft.net, ardb@kernel.org
Cc: pbonzini@redhat.com, aik@amd.com, Michael.Roth@amd.com, 
	KPrateek.Nayak@amd.com, Tycho.Andersen@amd.com, Nathan.Fontenot@amd.com, 
	jackyli@google.com, pgonda@google.com, rientjes@google.com, 
	jacobhxu@google.com, xin@zytor.com, pawan.kumar.gupta@linux.intel.com, 
	babu.moger@amd.com, dyoung@redhat.com, nikunj@amd.com, john.allen@amd.com, 
	darwi@linutronix.de, linux-kernel@vger.kernel.org, 
	linux-crypto@vger.kernel.org, kvm@vger.kernel.org, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Ashish Kalra <Ashish.Kalra@amd.com> writes:

>
> [...snip...]
>

Reviewed-by: Ackerley Tng <ackerleytng@google.com>
