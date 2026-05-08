Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC5C3C1F
	for <kvm@vger.kernel.org>; Fri,  8 May 2026 22:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778280610; cv=pass; b=cXuaMeiZ0b4tXy4eyzqJJyp8ZUw966vCnBwUlgZA7lDL+jafQ2+clB9QRjibRzgkfwwQTxvbnHmQ3sYonkBjLepNiZd6IvUsCT/NNsM0WzjOhKbshjQtthcwcPT61aSMIh6I5kp3c4L/WgBn5OLCQgvOA91ZZbPSauo155wQ30M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778280610; c=relaxed/simple;
	bh=m66sEWKo5ZQOcJ2VG5+XGsZOxON+EHvBXfOIjkS+b2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lCWYiKaRhVUH2/m/p1xu4uLBuaGIIMD13c9EMHD/jz0jtbpc43DmrUbN1f3KXXTa24McTbIT4SlPElzlddPYIC1MMbJkigRJ0y8m5F7LN6T45b8YaAFG0egrReH7LK9hnzM002iOZmBtqZx4RiLhkodSfdR2POCH15PPDnzn7G8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cEXVkd99; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cEXVkd99"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-130b2295ed0so7335854c88.0
        for <kvm@vger.kernel.org>; Fri, 08 May 2026 15:50:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778280608; cv=none;
        d=google.com; s=arc-20240605;
        b=HkU0/bZ04FFMF8/z3SfqX1fAR+ypQXEuWO1JzMrJ3xkkxjmzkyzXlWJdi9gbeAJ7ll
         hZPb0Fdf+ZeOP9sbY0qH/ch583NzHdGWfS5laGBlH6sDtHgsGgSDiJh8UmR4yHoOO7PC
         9zBXzUBQJ79BCNRcBMyjTIZ9VQcaoxCGMkeM7tqpI8cKGTUwwf8ZTnjDx56A0j1FnJH2
         LdBHEj9afv2Qb0hnTFbLvQUxbr9ChQdFufL6bhvC+cDPIeBX40AkTRy3dbDYKOK3VDJM
         4MbviATq9ts4BqasVRI0frB6xv950c6+UYVfZ1xYC/lYTJZ+HY8J/NffTI0uDfXXO2Fh
         Gigw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Lj8fzWHARsbMO5lQufiYoJeosFJ69vYejyw1tmw5mQw=;
        fh=0QECx4x03LmN1RRwHGsSpHhVIuJeQQ/WcK7nGlVS5FY=;
        b=Qlhr4uIkO/uVExn4AiYxH/Ys8yCq0KcgJ+hqOu6NVWpuNAOj1yJRU1MZqnJ8btqccG
         vzE8tx8RHIXAQ0adXwTr7Tx0c3GkWXCoPypnUc/1/yi+lJKh60dwKZEWaGDLmvgmlrUV
         3q/vFH4PpddrP95ecpatnxBxXg6sw668yyj4+dt/Kn+QLixoq3Dsc0cv0N1YdYe+Kidh
         /frA/b0TLFfn+Uvl7i+WM9+vB+owRbAUNCQqD+Zwk+Pm9ObhNVFYebQDIsFSta+nRcke
         p5x0uad66h95pgPRTbgp4gMK7wC5/7lC9GbCkqUDKBAz+DNspCokShMZ0IiUFMkVX3Jv
         zYdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778280608; x=1778885408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lj8fzWHARsbMO5lQufiYoJeosFJ69vYejyw1tmw5mQw=;
        b=cEXVkd998eMSWeZiGfhGzMtHl88cxQyv4LNBYw8hAhElx5dfTZCSjoIyjXQ0z7Hroy
         mrEFRBYcUJC2GSK5XAWbzuBvnyYPbSyPsjd5Lp4mGlaQpDagC2qufHXLkuUfyp2+5Yvr
         GoHct7cH5yzRms9laZLokN7AVqOOn1V+DrQrrH3YgmA1mHikcviDFK5A418cT1AIwHDh
         ixXto9hM3DLDiMBLuo/+vRAc0oi+Qvn9AEgzSRbzZkPk/DCCVMUKmCpX0tJxI+MeazcJ
         c4xDGU8kxmWqKF6viax5R+F1qJSgtLL+5aezJHkubgBdEsZCzN50TWycPbGjfmwuq+Q1
         t4JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778280608; x=1778885408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Lj8fzWHARsbMO5lQufiYoJeosFJ69vYejyw1tmw5mQw=;
        b=CAQYKIGC53aTdQorI3I787R7JGumWFlmHcMaTmBes1r+iAqXgimADFc5nch9G7wNsW
         r9PCZkPJfL9G7uORQ2hVbP/qpt9af4tn70AyoWXObLlSIgjztG1DRdDOm7tUBXf9oxig
         X95sOa3SW6SKD0jossrhkPuqF0s8U8bFuUa1RRN2cf5G/l+qj31U1S9KAxy6mSe4iqoj
         +cgHWMyHSNoN46t5G1ZpJ9BHB6UJD3MMHfBMs29z8PHeDkLIHP35VKtbDZARB4jy6XU9
         SL9SRwWqPYULhLyAtPuVFiOgk5Spjbv4zx8XwdDoYw2jwiXlXARHf2N/8gdDTg0tlFhG
         0B9A==
X-Forwarded-Encrypted: i=1; AFNElJ+kUtQF2T/WpCo4z8NSxzdsY3fSx0hwcGFcfbvno34Wcm3Fej6Dd3x0YoMFVTCFA2+rCsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYRuyjgKO8t5kIHBqf855Kg+lowsbJRzj8hU5/qm8b5hpZjbqJ
	AvUfY57XBFpNiYra8fAhsTrf/q//xtGu50kmN5F1hDKGgBhx7FAP6WQp96ZFLFANFbWtvPuNqf7
	5pmd3i1iJkSaYj84DbrU2AdAELD6Sm9rXugqqcPYoPTeI1a18BJyVUiWX
X-Gm-Gg: AeBDiev+adHlmd+kX7wdJz0v7R9D4OtUQlEU6XZv2sGe70xApiRHD1Q70p8KESWwICY
	g8hikYu03rx294M7YywXgVteFiVvnuvFmRll4nTFtjE0R+Vk34XVdzEQbn98ZLBARjmqa0WoPcM
	kSIiPNSWS61DzQhxK02EVGGN6+ADf3xTyEhdOBigF4LAsb70mrkawYDHJ4AoXv86GjGAytECMBK
	CDdqeamxQu93Rxv9fGJAQ2siXvgSxNi2Q2fTogEt3opSI8205RpVmNP1sL+WoIZaKHTZOORkCZo
	kqkNW/jvRy+b5Iv5CwQ=
X-Received: by 2002:a05:701b:2204:b0:132:7ab5:6cb6 with SMTP id
 a92af1059eb24-1327ab56dd4mr1398920c88.2.1778280607748; Fri, 08 May 2026
 15:50:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414230943.41198-1-jrhilke@google.com> <20260414230943.41198-2-jrhilke@google.com>
 <af4oqOB-zXgVgkLf@google.com> <CAAdrzjtvG2XrzjxFqGPOyiFL0QWeg-cY3TMdsj77ZdLivO8R1g@mail.gmail.com>
 <af5hqRVaI04EG019@google.com>
In-Reply-To: <af5hqRVaI04EG019@google.com>
From: David Matlack <dmatlack@google.com>
Date: Fri, 8 May 2026 15:49:40 -0700
X-Gm-Features: AVHnY4LzJdtGAUT98v71tZFuO8Vkd2aaIZDyImsHG58_hD2Fk8kMF9-WSwCx-Zs
Message-ID: <CALzav=fhgJwdk512Xzr94woo_7JsOwNNZs-E43HOP6+e0sda0A@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] vfio: selftests: Find devices that have VFIO
 selftest drivers
To: Sean Christopherson <seanjc@google.com>
Cc: Josh Hilke <jrhilke@google.com>, Alex Williamson <alex@shazbot.org>, 
	Vipin Sharma <vipinsh@google.com>, Raghavendra Rao Ananta <rananta@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 8, 2026 at 3:20=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Fri, May 08, 2026, Josh Hilke wrote:
> > On Fri, May 8, 2026 at 11:17=E2=80=AFAM Sean Christopherson <seanjc@goo=
gle.com> wrote:
> > >
> > > On Tue, Apr 14, 2026, Josh Hilke wrote:
> > > > +# Print the segment:bus:device.function numbers of PCI devices tha=
t can be used
> > > > +# to run VFIO selftests.
> > > > +function main() {
> > > > +     local vendor_device_id
> > > > +
> > > > +     for vendor_device_id in "${DEVICES[@]}"; do
> > > > +             lspci -D -d "${vendor_device_id}" | awk '{print $1}'
> > >
> > > For ignorant people like me, it would be helpful to capture what devi=
ce was actually
> > > found.  I mean, I don't necessarily know exactly what these devices d=
o, but as the
> > > list grows, at least having a general sense of what device I'm going =
to be feeding
> > > into VFIO would be helpful.
> > >
> >
> > Sure I can do that.
> >
> > > # ./devices.sh
> > > Intel SPR DSA (8086:0b25) Device IDs:
> > > 0000:6a:01.0
> > > 0000:6f:01.0
> > > 0000:74:01.0
> > > 0000:79:01.0
> > > 0000:e7:01.0
> > > 0000:ec:01.0
> > > 0000:f1:01.0
> > > 0000:f6:01.0
> >
> > How about a "-v" (verbose) option which prints the device name
> > alongside the BDF?
> > Works for me.
>
> > $ ./list_devices.sh -v
> > 0000:6a:01.0 Intel SPR DSA (8086:0b25)
> > 0000:6f:01.0 Intel SPR DSA (8086:0b25)
>
> Maybe add a dash to visually separate things?  E.g.
>
>   0000:6a:01.0 - Intel SPR DSA (8086:0b25)
>
> > This approach preserves the ability to pipe the script output into
> > /tools/testing/selftests/vfio/scripts/setup.sh to automate binding the
> > devices to VFIO by excluding the -v arg since the setup script expects
> > a list of BDFs.
>
> Alternatively, -q for quiet?  Or:
>
>   ./devices.sh | cut -f 1 -d ' ' | setup.sh
>
> Or have setup.h do the cutting?  I'm a-ok with a -v, but if the script is=
 mostly
> going to be run by humans (no idea if this is true), it seems like it sho=
uld use
> the more verbose version by default.

Let's do -q. That makes the default (no arguments) usable by humans.
For scripting, it's easy enough to pass in -q.
