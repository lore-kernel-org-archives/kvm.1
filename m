Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082AA433BDD
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 16:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783441056; cv=none; b=PtKsXF/7OP2nsmtOLt+HdRDxoPoUkk03fOdVLT+ui/4nHB7p99gw6OAifBqaT0Iql6pz67KuGe+BJuHTlfLDCGZLuEgsaTSeYPJBVGLVsmzfCuAT9hmtiBoEplKcrYIQWKUkndTVMaKr+ZBwCZlpKx0C2jbymxUv/iXKFQr0VHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783441056; c=relaxed/simple;
	bh=Al6q5hSzbakCy6OHe7OE0sutONb/Jedtd8RaoFJGZSw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Xg25rTRjRCLsEcxwNUTrA/d9t9d/zpKiocVx4eM8S1YYFZw8fSti3ChJja1dVS2Z+a0hNk66UhQvn1/GQjOySl/nb/GSEzkuGZULFoccrFYm8MsFZigXkmhsSdZ0mcxjGStwGT9zW0nTB3FQuwe4jzopNjgiqg0kmGTFI/UV27A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dqn5gt3A; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dqn5gt3A"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c860544c077so11847050a12.3
        for <kvm@vger.kernel.org>; Tue, 07 Jul 2026 09:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783441054; x=1784045854; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Al6q5hSzbakCy6OHe7OE0sutONb/Jedtd8RaoFJGZSw=;
        b=dqn5gt3ALNtUxpyQsP4DBIgwh/sLTH5z74M7MjJQoV9JhhpmiMSa0GFGBEdf4EtXtj
         jaHKMY1jxlU/uS9mnH/8RBAOLaIyXKwIATM9qO8WIvl438sgIQafXZR4gzGnGowCiZfH
         mmgS63j8EYi0qkgtACh17NbloZmNEvJV/tYsMmP1qlC+wjK3JHlQbA1cEJvho5zQ2xbB
         9jl9yUUMMDpxQpH1r8nQRbWE2Ywf7Lak4tQOGIYE8Ipu/nsL1ZIWq4E86S27g0StD1Ng
         0g490i45h4KPleA8FNX5kkBmV9Yd+LwnqPPBblOvWCIUYxsDHLFB2hWy4s4jqyUYuNrr
         jBJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783441054; x=1784045854;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Al6q5hSzbakCy6OHe7OE0sutONb/Jedtd8RaoFJGZSw=;
        b=XwyUhE8OSoCKAZN8ig3+Utd0cTDlbp7iaqftjMg+RHpOCU8ZIyXpdcdZIJHgJWPtx6
         pn/FVskQJlPmqBbJkjOIYhBH8NVtG8WEEIB6K/Z0yBra2Vp+HCO8XBYkLflhAXFTYHwi
         v4e+jfLhh1UAk/x8bpLAhaR83J/Otq9NuttdFaHYphHH+4ki+zvQEtY1KJ4DQGYcwi/s
         TDuM+v7ng/4wfKbHucoNp77rg/qFQhwKvYxGkOT8jZLUvlkS4WaJu4YRyrlzyrXa96Gi
         X2Q7C0vJSfTDnXuzzczKrHibPQ8302yeTy7k+mphrpM/wamYoF0EpWLzoQjJuNMk3u8x
         VnHQ==
X-Gm-Message-State: AOJu0YwAUKauJvyty6ZuF8cHrBWtT2/CIjSCh4d419tnFQoLot7bjZ0y
	YZpG2Re7H4U5rhHxrmR++dIZp5+HnPLzPZJJUmg5ekiXJmjNchER4NwCaPQPOsUa19iVU7RXxLr
	1xZ7fGw==
X-Received: from pgam21.prod.google.com ([2002:a05:6a02:2b55:b0:c99:d21a:f6b1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:c786:b0:3b3:be05:2b73
 with SMTP id adf61e73a8af0-3c08ecd72famr6686068637.18.1783441054198; Tue, 07
 Jul 2026 09:17:34 -0700 (PDT)
Date: Tue, 7 Jul 2026 09:17:33 -0700
In-Reply-To: <f2b2a3a048ad6429305e0e21319a8c27bedf39db.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com> <f2b2a3a048ad6429305e0e21319a8c27bedf39db.camel@intel.com>
Message-ID: <ak0mnZKoxK5Y04Dw@google.com>
Subject: Re: [PATCH v6 00/11] Dynamic PAMT
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, Kai Huang <kai.huang@intel.com>, 
	Dave Hansen <dave.hansen@intel.com>, Yan Y Zhao <yan.y.zhao@intel.com>, 
	"kas@kernel.org" <kas@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"nik.borisov@suse.com" <nik.borisov@suse.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, 
	"tglx@kernel.org" <tglx@kernel.org>, Vishal Annapurve <vannapurve@google.com>, "bp@alien8.de" <bp@alien8.de>, 
	Chao Gao <chao.gao@intel.com>, "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 06, 2026, Rick P Edgecombe wrote:
> Sean,
>=20
> On Mon, 2026-05-25 at 19:35 -0700, Rick Edgecombe wrote:
> > =C2=A0 KVM: TDX: Allocate PAMT memory for TD and vCPU control structure=
s
> > =C2=A0 KVM: TDX: Get/put PAMT pages when (un)mapping private memory
>=20
> Would you be willing to take a look at these two patches that need ack's =
from
> the KVM side? I'm hoping to make the next version of this the last one. S=
o it
> would be great to get any remaining comments before then.

LGTM beyond the to_tdx() and Assited-by nits.
