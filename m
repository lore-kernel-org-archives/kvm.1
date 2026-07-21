Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BEB46D0A5
	for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 16:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784651052; cv=pass; b=cllZ9fMTPibekPoRBWPPgCyGpt4lhk7hqIMT6Xl+fVcplj1k04RRls92JNQTO/qQZMFqbCLO+J9h9JNhQT1dihthq7iTOVCuwHkSVeD4lfHNRt+SstV9mAmU2Pgae1Hzr3XST7JTwebUMx9ETDrfM9DLJrKYp740uhejxsM9myk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784651052; c=relaxed/simple;
	bh=w7TqouPLSZWjqpS6SB6Qduh6O2/m5T9gRHXf3A1juLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SeKHe3N1lQ69JTSy3QGfQ6EU6cyd31MLISibp/7jXP8hoqhNKmR56x0YvEIfKk+TeVlO5KNXDFU6qJH1HUEnIZO9yCwrjxTZ3MYLbs0bJGXjYKuuEwhXuhfsUTAy8NFQM0mYR6Bj3Xg6wNa5bG9b2S4+Vn/5L2IPYiTWQU6LtfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b1SXohPs; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b1SXohPs"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5b2a73da7e1so5619e87.0
        for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 09:24:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784651049; cv=none;
        d=google.com; s=arc-20260327;
        b=gq+otIL8Ty352uHJ1pJI10XbU//nfaFZ9jtP6QeIce9f3cpexBxhp093JlbEfZmln5
         bPr2mwhI5RdN1sUuJLQOwkZoI1Fzwf6lng2GonrXC3SrlIHA0hoOBYCv4I+OncK7Onim
         DDOLoUkdoln+1j33fn7QLBbmGi7dmNgfuiesEftZU8easy08cN0vojaSMyfJTGzzsPiC
         f9tq/TwKyG8AgK8Vi0F7EMc0kz0YBDo57WnDB3M797DIW+CUTtMT7mFulm96dXQWObZF
         1LtqhismDCKQ30FcOpInmoZYmzZOpeurIK/P9HzUsR7S0pZQ1O8mD9jA5QNBj7W9Ps5E
         IUyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6IIRL+XPWpelEfDBhGxVOXyFyatQ6xSvU7ZF4RnBpbA=;
        fh=dSPQZLZeoNPlxrVO0Vk5YNxgdGdDo9BoZ8Pud8y6vLY=;
        b=hHzi18FRY2MMb2OHHZHaHQ5UCN09Q1PddTUt208w06Yb+Qyiploi50u6MgX2MBmaHJ
         hkW80sBXmqN7DjuQa7UV2jcgvygdgbRaJv2RjgezJcPg+filitcRgRWUH6lBGz8CKURm
         t+9FMjxeBfdHKF0PFpIoZkMdaAHDVBQSQFKWm3yqbQipIA//V2iZfRpyxbSTXM7nSTuY
         RrAWuq1Y0Wbk/fZWqur0OiklbN8hK4uLOZHhqBtfscszEhQq92n6muoyJ0yuTo+9Zm0o
         PA2KarvPiUQDj3IQDw+mgVmvRwsVoCerYp6RkWY8nk0DPHn0PZNxhZEe3Yc/b8XQmDO+
         pBXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784651049; x=1785255849; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6IIRL+XPWpelEfDBhGxVOXyFyatQ6xSvU7ZF4RnBpbA=;
        b=b1SXohPsmBhAjNS7tX+7wCgZ4XVGVYt0n+ahCjH1IBuK0f6JnYp+h8QLJBwO6cYclx
         eWd+Ym4NbONLzFtQX5WleFaDHg2jh8hyrei3JJVBGkUvPV/qGNW2+1HRcazQvnRpgZUj
         ZBZMckX+v0xZKf6z60vUBYxYaYJhXW1e0IJXGnvcObLnhtloIYt70Z5hi6yzdQ+5UHO/
         ylpHPCYl1UQUp7lhcnmN8FXKOy7m3RNH18cBvhonDwa+42Q6OLz3jEHZP3GlMLwWpVt3
         awURqbHbZoYrrkSRcxlq3wAwYb5NDD8L5aeUFq8Aw8vssjqpuj60QQMCvUdWUr3oDndm
         JEeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784651049; x=1785255849;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6IIRL+XPWpelEfDBhGxVOXyFyatQ6xSvU7ZF4RnBpbA=;
        b=GtIwb0NVaom90dbk47yayntD8vg11Wt+GO1dCcnCxSqV290SdYOzZ3y8eD2WVoe2t2
         eCGTwpvFh4epTNhwGfP6auEI3bt1uE8Dbd5T1ZH1eloSle5jujpx8lzXhE5LBSTRTV8X
         UdEbJr8JzIs0PPPJ6K0M7r+PVEi++ay7j57FnDS706+EPVlT3iel1UiIs2Quzz/KaV8r
         3Y8hWvzQFBcxo7fyeQBkQsDk1eDeaTx5PfUOinn5CMo/lZtj+TsupPC/CWRL99fNp/fL
         YT+EaL9yVcagVPfq5wJmcLHvncMunBPAVqduHhQ0vi0h2gA05OVsbfmKPDiZeV8P6Vrz
         xlkQ==
X-Forwarded-Encrypted: i=1; AHgh+RrMYyGX1EvJ51v5Qo9WXpt7SjEo/FiIPjcU8rTcdQnC6vueOtKUbfnRgd3TY16nsNneJk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrrEOZVAFUWgXIdk/YbtKEN8A88D6ph4s6wBj6z57dzOm8uiRs
	xEdJpnmsXRX06a0nltgEL+3rHJht4SdTd29JNUSk2JsONCbvn0iOMGinwFEHTDJ3/JqfRvlwOXe
	sers5c6POISYjFSLULCF5dsw9g6Om0riD5a021yc=
X-Gm-Gg: AR+sD10RJcr8z+dC0FU3CqwXGoVcy8ivwtbubxaAYGQ07eS0nph+C9XItLn9oTRCn9t
	qSO8hvnsnFsAeY6IVezIl1DOrNl6AaCx9vOchujvUH/zkU3nW93exDXeUa8BbwLNSKxuMeJC2EH
	oHs+qFK0vusCLxesZV+Ly7mmEa7FlGP5tnvX49AaIpnaBxwWEJGQ1/R5HTe13yIBL2mML/J1LmR
	rSj1YlCIs1FIeXSgi1qgRPumW4wZO4iLRrVu5dWvhLmTNbU0dPW9GWoiQ==
X-Received: by 2002:a05:6512:ba1:b0:5b1:5141:9156 with SMTP id
 2adb3069b0e04-5b2a31c4862mr327591e87.9.1784651048492; Tue, 21 Jul 2026
 09:24:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714151505.3466855-1-vipinsh@google.com> <20260714151505.3466855-11-vipinsh@google.com>
In-Reply-To: <20260714151505.3466855-11-vipinsh@google.com>
From: Josh Hilke <jrhilke@google.com>
Date: Tue, 21 Jul 2026 09:23:57 -0700
X-Gm-Features: AUfX_my4kAQgnpjbhryasf2kLrfrl2S4l9xVYW8Rn_Ur_MRpX7wHXzL-Nzt7PMM
Message-ID: <CAAdrzjsEG2DQoQbNe4aeq8gNF4Td+N6_gTifU6=EzAEuySu7PQ@mail.gmail.com>
Subject: Re: [PATCH v5 10/20] vfio/pci: Retrieve preserved device files after
 Live Update
To: Vipin Sharma <vipinsh@google.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, ajayachandra@nvidia.com, alex@shazbot.org, 
	amastro@fb.com, ankita@nvidia.com, apopple@nvidia.com, bhelgaas@google.com, 
	chrisl@kernel.org, christian.koenig@amd.com, corbet@lwn.net, 
	dmatlack@google.com, graf@amazon.com, jacob.pan@linux.microsoft.com, 
	jgg@nvidia.com, jgg@ziepe.ca, julianr@linux.ibm.com, kees@kernel.org, 
	kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, 
	mattev@meta.com, michal.winiarski@intel.com, parav@nvidia.com, 
	pasha.tatashin@soleen.com, praan@google.com, pratyush@kernel.org, 
	rananta@google.com, rientjes@google.com, rodrigo.vivi@intel.com, 
	rppt@kernel.org, saeedm@nvidia.com, schnelle@linux.ibm.com, 
	skhan@linuxfoundation.org, skhawaja@google.com, vivek.kasireddy@intel.com, 
	witu@nvidia.com, yanjun.zhu@linux.dev, yi.l.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 8:15=E2=80=AFAM Vipin Sharma <vipinsh@google.com> w=
rote:
>  static int vfio_pci_liveupdate_retrieve(struct liveupdate_file_op_args *=
args)
>  {
> -       return -EOPNOTSUPP;
> +       struct vfio_pci_core_device_ser *ser;
> +       struct vfio_device *device;
> +       struct file *file;
> +       int ret =3D 0;
> +
> +       ser =3D phys_to_virt(args->serialized_data);
> +
> +       device =3D vfio_find_device(ser, match_device);
> +       if (!device)
> +               return -ENODEV;
> +
> +       file =3D vfio_device_liveupdate_cdev_open(device);
> +       if (IS_ERR(file)) {
> +               ret =3D PTR_ERR(file);
> +               goto out;
> +       }
> +
> +       args->file =3D file;
> +out:
> +       /* Drop the reference from vfio_find_device() */
> +       vfio_device_put_registration(device);
> +       return ret;
> +

Remove extra newline after "return ret"
