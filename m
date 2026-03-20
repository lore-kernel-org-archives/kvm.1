Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3566831D362
	for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 15:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774021170; cv=pass; b=IEcJLXqJFIv8XqrQUwAvjL5sH14BYLpUpIHu/RJt2xQ7EFV8zH0TdKk/v498gzw1OjKH06GZRB/8OuPqBBGxyP8sUYo4SSbKDbXo6LJniCKWwH7dIt3HSuhnUCN2vvyGyd+bWPywIlgg0C507Xp+dsGlnXVp2pT2uxiqkxpt1kw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774021170; c=relaxed/simple;
	bh=chgcSRYsj8N0hiOmzDKpGUiSVwJE625pHCuXPV8ofCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YFIqF1VC+tndV2pU0uzo0wemqFKQ08VBhqQPl+gLQ6wYDEOifLdLJa1yHeQwmZi1lL6L2pBwHcZCw0mky9chFgPANtWAvlVwofKeYr2+QcQpcW26XNxKzbsGhRKuQaUQJ9J3o3LGj1NCEdeHNsPTidrKan6FRuJDHPIupwz/5Lk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KT17nNjN; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KT17nNjN"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a1443780c4so2718493e87.0
        for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 08:39:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774021164; cv=none;
        d=google.com; s=arc-20240605;
        b=KP5TZ8I66ii8NCwbMsX9lP/zqVEdvw83zIABZgtqEDRQEa8WuT5ngLH6H1v51ozyzu
         IYqIQhpaFDc5tJbe/+5GDr937B/RuQUmOnfo/1g8az3F6HTUMrRQ4Xk2nTlARiMY69+E
         6d7O53cmsVxgz0l37V+PQKGb7iybGZFyO8J3m1+xlNObRB8vzqHO9nZS9H3q/DzdYZM0
         uGd9Ze3c75nfhT9t1HcwGcL9DBljK8Km0ZUMJOcD0kuj+Sce6Fsz3yOO2p3YxmH/NUCz
         628IK2GQohHnF6ysMRJURMGu01IaezLhIJPNQV3jEbzqAs6CBOiZUKOOsUeXCZEeBY8G
         R4Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6tEASViCDgGpPWmKGrjem3hVHYFcIgQS0LV4EwIiBtQ=;
        fh=UobIoI5qf2tWVyo+dMgZd/iXGOjHDpHNBO++FCExWX4=;
        b=DONswU1O7qr/wv/vvDh0Gza+lQqpzovaO5gNuPjVbFGHXy5t1NDrBpIbOiLAClmAYk
         82clSTOgyhdxUKQdFXbATZ+f3/RwDg8FuWlStHkrsXU4kRhhDy+3hM3MQ7bZDy6lw5Vr
         ZeU3y5LtGP6CrcUA+xnPbnLNSoYB1eHgoVjQClKKsVibfeVZfIinNa+9+FR5LrH0oXFe
         TBlfE0/WnUN1uFayXU1kUnSPxuXw1MjBUClLRwrL43qa2QYHk2GKjXgq0/t26YMhnmiO
         q0hJFZZUiJzzyyVaZzzc98vobxBcGsZGX8OF9FJS2eujUy9bEtboTYxgewQBWvBrvYkV
         onmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774021164; x=1774625964; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6tEASViCDgGpPWmKGrjem3hVHYFcIgQS0LV4EwIiBtQ=;
        b=KT17nNjNbQH9As/b1rcGZU0hvGHHPJ4zAJU7YYSPUNa0RlDI14t4ZqxzU8zewx7AOX
         EgDIarBi4mgzsDmUEelnbVj3ZeBdo452r4fzuDu3jvdyyncFSHGDv8DhDAqemTONu4pY
         Hxmsiu1Vmc9C132zvK1aQGUeS7SF4xCDc44aBSs2/CggZNj0wSCjklBk+Swy2UovHtBp
         Vf3kkgSddcpEykwLyi8T3bcxT6XRHgSYp280sveDep6Rc1Y8Q+Rtp/YsMqetv9dXXg2r
         rBshjwefDZCbg3ISKoO0unXyPLDykWp+6e0HBvgWszwsNfCD9A4CisznFP7ZtMvVmQL/
         6/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774021164; x=1774625964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6tEASViCDgGpPWmKGrjem3hVHYFcIgQS0LV4EwIiBtQ=;
        b=occtfvXPEnaM6BRiPJ0O7GYeGpeGKti8nmcLXKdFfKsnJ/yRK93beIqPgG6i3JcQan
         rBhHtePRT4ja9mdBklkJ6oNLngMl6xuPs/hxH5M/A/HvsnpJeZoiTmfhLWt7VTtVTosw
         UQU7yIQHi74BTpjcwtIIinhL1UD7NbzPidyaGzUdpBYjK+XOLbMZ7gKHeNFy4bwvMhzx
         x2JLS/aRMVq8DdpPHoHrjuQas+ryiCFCgKB5Rp2hE71+X/tlkbtDOnxc9zmoDkACeXAC
         MJJ7c6xWx82LlNgyv9q07nad3uaWy48xnAzJCL+PR9RMY8RO1L+D/N/JhzLpz9z3Idxe
         fpFg==
X-Forwarded-Encrypted: i=1; AJvYcCWd+GE6NLWdbeyo8hVVFw/73wDu9BWwI8ETA5FIhjS+WRtfw3sb+z20K6RlNQaITmQoogE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWCIKZqndy1CZUBusCsaVCtteu1dLnN5P3cDZHEzJjOqWP6klX
	hPHzIhMpPIunYlnkq8N8vgPPIsJWpSZRFWjDDMUKA1JY8Kk0OpDda/yenXt758AL2r15/dKX0+r
	f2b9w3uCwDB91BzKhqsYVUDwDJXcNTnz+pb+sUU7U
X-Gm-Gg: ATEYQzzaPMEAAYfNQTDYlXQAidwusT2xFI0W5BQ4s1/iAH70gNCwrVXPM0kJw5rtA8F
	c38QlIkwxsAX2rEPdzVAhpuG1d4yw7GhnM8vkyzM4GqFPZwAWgHRN1aod/aytb0/3kyYaeQKs7+
	EVBYGNL8wKa3YrbuK5BZbgScBAO55FZ20Ys8zB0NGgZboGiSwkjZ5awo0bvvgm9NXR+9gPuE7aC
	cLl8Hl1wt3iMa8tByqGaZ/X04qZcFpNj+RcvDfShPhgSsTYxZE4JXeywcNntVZXV+feFgQ78cjo
	LD2K36GZ
X-Received: by 2002:ac2:4c52:0:b0:5a1:42ae:88b6 with SMTP id
 2adb3069b0e04-5a27de4f200mr2823773e87.18.1774021163672; Fri, 20 Mar 2026
 08:39:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320010930.481380-1-yi1.lai@intel.com>
In-Reply-To: <20260320010930.481380-1-yi1.lai@intel.com>
From: David Matlack <dmatlack@google.com>
Date: Fri, 20 Mar 2026 08:38:54 -0700
X-Gm-Features: AaiRm53xAk-g3r9wQepDcgKbYKM9wGMEW73jp11NhHmcueWyQ_iS-zO8WHJC7NU
Message-ID: <CALzav=fb8Tgv92FMv-yi5q9xesbBy4_tEq+Vyyypm4MVJ6YfHA@mail.gmail.com>
Subject: Re: [PATCH v2] vfio: selftests: Support DMR and GNR-D DSA devices
To: Yi Lai <yi1.lai@intel.com>
Cc: Shuah Khan <shuah@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>, Alex Mastro <amastro@fb.com>, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 6:09=E2=80=AFPM Yi Lai <yi1.lai@intel.com> wrote:
>
> Currently, the VFIO DSA driver test only supports the SPR DSA device ID.
> Attempting to run the test on newer platforms like DMR or GNR-D results
> in a "No driver found" error, causing the test to be skipped.
>
> Refactor dsa_probe() to use a switch statement for checking device IDs.
> This improves maintainability and makes it easier to add new device IDs
> in the future.
>
> Add the following DSA device IDs to the supported list:
> PCI_DEVICE_ID_INTEL_DSA_DMR  (0x1212)
> PCI_DEVICE_ID_INTEL_DSA_GNRD (0x11fb)
>
> Signed-off-by: Yi Lai <yi1.lai@intel.com>

Reviewed-by: David Matlack <dmatlack@google.com>
