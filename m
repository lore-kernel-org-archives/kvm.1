Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F11194C96
	for <kvm@vger.kernel.org>; Fri,  8 May 2026 22:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778277811; cv=pass; b=l8WL1ujR+CrxCJbLz0ZxYHMfYvpNvIXntAwNKIMCTqI++7i/JZESMyxjGRnhKZYdg1zN1ehn3IKmXhAohW30geOA6W+z5m22KUYXk+8gbcumE3cYB2n26e6vog2yThT0WZeOWBflGQqcvk/pR9Oj872RhEIcq/IfMJsQZ3O6dR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778277811; c=relaxed/simple;
	bh=DmfMChLTaS+4g2+HYePa7/JmroJ3rrylDOP86UgrUuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SD+fEgr6cGQ4b+/nT5AaNQHAc0uNicFDk3Al5L2Bf/aRaXVN7NoJjcrfS/8TKrw/MiivjIbp6jfA9F9nJKuV14Aubqyq+T+oG3UzNB3hL+6wEJSxEf5I70d6BaWEdB7iqzwS2TmqKtTn2Qw9DiL4ofF5k8SAisqSmOSQovR8aGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uZl59qCE; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uZl59qCE"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50e61648f10so9321cf.1
        for <kvm@vger.kernel.org>; Fri, 08 May 2026 15:03:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778277809; cv=none;
        d=google.com; s=arc-20240605;
        b=fxSl7STcimNSmtQNT9TQwHl3IuMDdEIc5sLchr9qOZFl+L2RNIL0q+EQvDOGaicMHh
         9/DZuQ2se+/LueLdBtdvJGr7IWOxVv11WeT6OFHsVQ52Vi3hhUMsROmLnSQ/Hwl1XleC
         nDT59RBgQgkZlxUml3w/xkftUaeayS0jFPl7FgGtrSkLy+Mn5XGiPTNYPWhkzU/QyTE0
         nXNRqh530TpSKf5YWsDq0dTVYhgSDAG4qoxrCPh2LR7k9kJxqCc6CozOZezw/HFY7ZPh
         ZR4t5xChGRR78CDbKIAJdijvfARyxAhp/M6Ng0AhJaPmGyBcuABkNrHvMGHkmc3x/5Rp
         wJ9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mj3U9pDsQdH9lfZhkNFfjmimlhdS0kWH4zBOY0goio4=;
        fh=W9bmRIAinkTDun6JeaAfkr4MtPGsJkZuIdUAxV3aFMQ=;
        b=kDqLUuMgOgzfiNuw7NpQ0Yp9wDUuYRM0KbpEPPYbRYVovp/X1y3DvZ9RLbjuKOTDmY
         aj98I9raMXT6ByGORugIGfrf8Vctg9Gqha0HuG9Hj73hGzkjh6BrGU1ZmSg0HRTLXzxb
         2YoEAWMNyH03Nn/PT4sXM+95/jXOZ3kM8Ya6TsFsndVCT6hqcCWRctxiN/Hrs7i2h1RA
         8FY2cFsBccU1s795aLPI6GgJ9G52WwhbIyJ2rm4xcHY2JfebVzKy2NlJeqG06A0Vitzr
         8Ubv0XUeOB5+CizyRm7mB8m/ObpUy6mNS9j5vV+dsghCZR0sXFoqPLxUVLByD01yDjwa
         sAZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778277809; x=1778882609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mj3U9pDsQdH9lfZhkNFfjmimlhdS0kWH4zBOY0goio4=;
        b=uZl59qCEV5LpzRBSMIN9G5oDd3qlNNymuEma4fvTHpt1uxtB86VJwxkUYkMOYxD9xN
         vPVz2UFdUIIHskTe4uApHORCye5aly0AiKAJdG0lUZohGkROYp8nGAgWddEpqYKEUk53
         PLId38rQfEvpv3HC1/AS5Mv+8/dRKjUIiSXLjQlumpy7zyWSea2uZJksWiUYh1RJK2Wo
         PCyYzSY/oY104ZAKkD8lOpvOWbKiFnruz17E6zMRuxvT7MvhXi98YJeJ8mmsltgh1ykj
         2+B8fAuGbvAjhU7i5oWCiN098xpOn5svx9au5YAfjrIt0JR7bm2TpTEYT3LK6JYICDum
         n4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778277809; x=1778882609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mj3U9pDsQdH9lfZhkNFfjmimlhdS0kWH4zBOY0goio4=;
        b=tK1wkGF7x+mKXeKfSrZkj2wompcfZzhN1uLX/IJO5WHRo1wBsnWVqjlu4YbG3tcCO2
         v6qLkzbNDbwRkQl3VD1Q2E3R+spHMGxxOFNNyaYdSxi/X/4exFxojp5bcCGuyXPHxxUr
         LnFij49VXDYw1H9QZTwIpX2yLbzIzat2I9rfAulyM7H8QnnhadGEiNhjSArqPHNpx8yW
         Yohqvg0N0dVZ9Sj5uiykt2dLXl3fcmZMNGZyx4ge1CLBCspVxdgTbI3QT9mR2/G3tHIm
         ksyf17tw/x+U7EicBAys6phxFeFWnMEukhm2lDu3+FV+nq0rW8VwoPvBTb7hHRV3vKsr
         nIIg==
X-Forwarded-Encrypted: i=1; AFNElJ8qZtnAdhKyFU5neMBbLlyLxSuQzQ8Bu8tVgp9R21I3MXfaboRTeYS2ytqhRxzd0vTsDlk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNwlijaxyYH6KvLLiUF/2tsiFX7EumtQwT/IMCfxRg84Ribzp9
	3fOrPFY0e3dpytqK2dxGmN9/HPBun6u54oq74qFvfRxw/ipaDJcsO8NSl/MBOYSJbd6dsC0XHpi
	dM5+R3N6QiGZpbD6lxMWutAqbJGZT/BywULJiqjE=
X-Gm-Gg: AeBDievsLkaA0W72yJFhuS2qkJwMTnszipnnGzk0Hmb9wK4q5FqdMj66z1mFL5vkKK1
	quXfXf6fJA9yQZtbBvuF8+W3iGJx5AHs4KGt+SH009KAP2y2v3dvx1TtF2ia3ZfoSvtRMgLP4hk
	StrbQvTufIJN9W+iHHfV0oibSomxMaT9RftRbx3ef6N7k3Pfd4TGR3nk3gPFEZMYBBWRnH3CwEq
	gpq8xFHGiJne3LORE5o5zNuO+0RR/H2n/X5cB2c/m61IbiqYMlPhL4SZR9jjPP49KRS/u5D6jRx
	YRUrrO0srDohZFdTHNa9N5avD5tHoU/oqbS+Oh7oBoCikf0=
X-Received: by 2002:ac8:5d8f:0:b0:50e:38f0:ccb2 with SMTP id
 d75a77b69052e-514a05ecfa0mr1415341cf.15.1778277808562; Fri, 08 May 2026
 15:03:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414230943.41198-1-jrhilke@google.com> <20260414230943.41198-2-jrhilke@google.com>
 <af4oqOB-zXgVgkLf@google.com>
In-Reply-To: <af4oqOB-zXgVgkLf@google.com>
From: Josh Hilke <jrhilke@google.com>
Date: Fri, 8 May 2026 15:03:16 -0700
X-Gm-Features: AVHnY4Iro_r0MixbPmecL75leA87BbFL28eqRUDfEqXiEw6QW-x_0PKuCIsFIDk
Message-ID: <CAAdrzjtvG2XrzjxFqGPOyiFL0QWeg-cY3TMdsj77ZdLivO8R1g@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] vfio: selftests: Find devices that have VFIO
 selftest drivers
To: Sean Christopherson <seanjc@google.com>
Cc: Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>, 
	Vipin Sharma <vipinsh@google.com>, Raghavendra Rao Ananta <rananta@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 8, 2026 at 11:17=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Tue, Apr 14, 2026, Josh Hilke wrote:
> > +# Print the segment:bus:device.function numbers of PCI devices that ca=
n be used
> > +# to run VFIO selftests.
> > +function main() {
> > +     local vendor_device_id
> > +
> > +     for vendor_device_id in "${DEVICES[@]}"; do
> > +             lspci -D -d "${vendor_device_id}" | awk '{print $1}'
>
> For ignorant people like me, it would be helpful to capture what device w=
as actually
> found.  I mean, I don't necessarily know exactly what these devices do, b=
ut as the
> list grows, at least having a general sense of what device I'm going to b=
e feeding
> into VFIO would be helpful.
>

Sure I can do that.

> # ./devices.sh
> Intel SPR DSA (8086:0b25) Device IDs:
> 0000:6a:01.0
> 0000:6f:01.0
> 0000:74:01.0
> 0000:79:01.0
> 0000:e7:01.0
> 0000:ec:01.0
> 0000:f1:01.0
> 0000:f6:01.0

How about a "-v" (verbose) option which prints the device name
alongside the BDF?

$ ./list_devices.sh -v
0000:6a:01.0 Intel SPR DSA (8086:0b25)
0000:6f:01.0 Intel SPR DSA (8086:0b25)

This approach preserves the ability to pipe the script output into
/tools/testing/selftests/vfio/scripts/setup.sh to automate binding the
devices to VFIO by excluding the -v arg since the setup script expects
a list of BDFs.

> > +main "$@"
>
> Why pass along args?  The script doesn't actually recognize any arguments=
.

It's a remnant from copying another script when creating this one.
I'll remove it if we don't add the -v argument.
