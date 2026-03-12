Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56CC35A390
	for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 19:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773342365; cv=none; b=E8GgfD4izpKKDUxLtIK3TTfqt+PoATRTAH1mZX99cCEidTqOknW4cF7yincitZXdbwPdmgBElca1V2+lIVQkygOquh1llEXyzJsZg1i0MsGS2JZfIWCVz8NTbNCDwVqx0awuQF26UNYXJ6AuNw8HPLdXgYXXczDqSGR6iw3l2jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773342365; c=relaxed/simple;
	bh=hTiL9Bf6qixzA/O8uITqxfCZEdegbOxjoMgziSOM3Zc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uqq9CEVpGmEGEAPvNrC1BtUYAHVH8+I89fw7dduXq3N+o1dLOkQ3ia1D1+HUR3cY/OGzn24c9gkcSEnzTIJ13oXwF/HhpCw2Xh4DT7OPtA/g9vEDQ0arf51wiL1siNS+gudyUzH/tDmpD0ujvK2wVXFXhzbUTlWvdl8KGpH7dsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h1AbXFmw; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1AbXFmw"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4852a8482fcso10834525e9.3
        for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 12:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773342362; x=1773947162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SE138O8UHt0c8RSCdcZ+MUjjq1yI/Yk0UU8sBlcjvOo=;
        b=h1AbXFmwfg/tM3Jbw7DgvodiNmG2KCb3ivpXggbdv2HrMlbKvEKWDh2pj78Xt8SO9i
         bC26bmFZsGw/LUYV7nGrwxNCKb2UWB78mMEj08TvuVPQQUZrEvgmwsBB1eAyikO+G4T2
         8lO7cw3vWv8T92Xb0kvpNetCqnIoLWLY5OiGarZPYt2JSeKTT+0SJWr8f4X8cd/9pVhc
         5cNl1qyq8cya1Y6SwiJsRiewMDkMcmVGK4yCS9bosjJ7U0pP2ngMZUUK9kS7nOWuY/th
         HWqCacAuylXqhNrIi7jWEbgPtRZ3pOXvSKa0H8gzqLsWwMJgZhnt11KNV8hE7rML1d8K
         ABsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773342362; x=1773947162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SE138O8UHt0c8RSCdcZ+MUjjq1yI/Yk0UU8sBlcjvOo=;
        b=QueR78dHWmjy+ze7u+IYyNNa2YVg1bInjBixlIHWsDySnpBgl/5bF+tc+eg5XUZ14j
         6bc5f0+4imuFym8e97A6BtFXhfzsenGcKcz/GvJ81Mrq6QdidwcXXdkfQx9lPR/WhnoY
         to/fB3gWZzN+aZpF/v2dVnbSpCZo6Ljvjz/n6RNzUosA8GkmsXOQqCoykz8BZyHQFvE6
         3Suahuf6yg1xRMbxiVRza4vmkkJ+pamvK5PervYnzVP1JekMJOfkgtDxZlZuT3r17x/2
         kjf/ybDQWg3KvYiyL1LcJj+0NqaHnzLrlQxajlRypq8WLZTxzuQHHQMs/5dstH8k8SGC
         gJjw==
X-Forwarded-Encrypted: i=1; AJvYcCU3vynGyUIup6VtjO2HBPPidIalmfEiAa7M9TK/q+gANCPj7LdOzfRa430CBf2eHyJwdsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSu5FVFKyckiFjwpskKPcNMaCDh6KjH7fPM1FWSU0LpS4284+L
	Zy+nZN3TffIpaewCKpQwrHXoNAicnCxI6g3RPs85QiaM0RpgEETXr4kF
X-Gm-Gg: ATEYQzy9NQmyq+HZWrcqU4pszLBXHQmIkGAtgarnxpDsORPXqZejMH3q/qg0ALQLWnL
	gIYj/UPESWQjthO4Iyd5Sk5qnz2W1nUV8ANJIlGNz0150m+Z6SzwYxRjMtsHPEWrwIUhtKkUhlU
	AI82LxJ3tgkKRTBLTSUPgk9YrvZpkjXfDoN+uZRXn8n8Hzv4DXgfP1CRt0zCBKUDLU7C2KfGqzE
	ViLfosS5ZYh5YJW3yXIU1NLU8nIOaKj1eOUqbnnBH79mORhSQTpj+UBQueHLekQvEL2ZGAcWPnJ
	iSt53eNAJ+dniStm3N42Xt4FK83at77/TiNQV/ICLi8VsatuiwqE1r78yLCsrPr8jSSBjGcqgaQ
	ZRSh1ahY3Ayu8zLpLFZiEBqHL2ZisOlGqx2DbAYmT1uAwOcinTI2lLMu9SL+zqwGAEj7AhCV5rn
	TQHTIuagrf2XofqYqw0lsfX6p6tYfU8/+e/Eghlq2tuTXB19jeMzG4O4ozzmkNheR4
X-Received: by 2002:a05:600c:698e:b0:483:1403:c47f with SMTP id 5b1f17b1804b1-485566ca5cdmr7578325e9.6.1773342361935;
        Thu, 12 Mar 2026 12:06:01 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b66ffe2sm140743645e9.13.2026.03.12.12.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 12:06:01 -0700 (PDT)
Date: Thu, 12 Mar 2026 19:06:00 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Nikunj A. Dadhania" <nikunj@amd.com>, Tom Lendacky
 <thomas.lendacky@amd.com>, Borislav Petkov <bp@alien8.de>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, tglx@kernel.org,
 mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
 xin@zytor.com, seanjc@google.com, pbonzini@redhat.com, x86@kernel.org,
 sohil.mehta@intel.com, jon.grimm@amd.com
Subject: Re: [PATCH v2 1/2] x86/cpu: Disable CR pinning during CPU bringup
Message-ID: <20260312190600.09e2493a@pumpkin>
In-Reply-To: <41851f3e-4372-4bd2-ac48-65aee3dcafe0@intel.com>
References: <20260226092349.803491-1-nikunj@amd.com>
	<20260226092349.803491-2-nikunj@amd.com>
	<20260309134640.GOaa7PQJli_C9QATGB@fat_crate.local>
	<cde957ba-3579-4063-9d17-3630e79ea388@intel.com>
	<20260309161516.GAaa7yFMulhdzNQ-pt@fat_crate.local>
	<70644e1d-dd0e-4f0f-81c0-fd095e46e50b@intel.com>
	<7ca205d6-b01b-4ed3-959d-db31a6496d79@amd.com>
	<505a6bbd-3ecf-4de9-8fb9-0b21c3435a96@intel.com>
	<9fa61b80-0e16-4a87-a0e7-3c3dfcda8f7e@amd.com>
	<55a98b6d-e831-47a6-aa5a-8fe357334f67@intel.com>
	<d0eba3fe-2938-4856-bd9b-0e13972e8313@amd.com>
	<cb492a37-3517-4738-b435-73311402e820@intel.com>
	<ddf407e9-359d-4d4e-827d-98f212589e9f@amd.com>
	<ab5bf7bb-6511-49dc-a65d-86911e0f7091@intel.com>
	<a078ceb4-6e31-4e8a-89d8-023b95f56054@amd.com>
	<41851f3e-4372-4bd2-ac48-65aee3dcafe0@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 12 Mar 2026 08:02:53 -0700
Dave Hansen <dave.hansen@intel.com> wrote:

> On 3/12/26 07:53, Nikunj A. Dadhania wrote:
> >> The simplest fix is to disable FRED on those kernels, fwiw. =20
> > That would work, but disabling FRED means LTS users will not be able to=
 use=20
> > FRED with confidential computing=E2=80=94that's not really a fix. =20
>=20
> Why not?
>=20
> Is there something out there that *NEEDS* FRED to function?

I didn't think there was any real hardware that actually supports FRED.

By the time that exists there might be a sane fix - or a newer LTS kernel.

	David



