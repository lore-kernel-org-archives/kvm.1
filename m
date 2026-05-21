Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BD52FFDE3
	for <kvm@vger.kernel.org>; Thu, 21 May 2026 03:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779335376; cv=pass; b=r6gOMStmu/TZcFTQ4MTVQM5FXlbOmagAIZS1WvdulOIdhpbhvdk4L4bX0urWPfNhOhseINwdw3jCM/BH4sD8mNDodvzRH8Xj6ENiR9RdkNhekng+rrZ8KFSPZmo1hPjrSdwkmmSqWKh1MKIMsE1cLv1GqtMlB12rT8JfESGQMHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779335376; c=relaxed/simple;
	bh=C+j4X1EjiAtuojkhVY0wXUNdkUfSZvrxMgm1ZzGtmaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eK0E310Bp6ed6tgEwI8Yqqr8O139yE/f/6v5O+CY8SKtCBdRx+pM91fBOOsVFq4mEo9Twk9St3yFcXtVyBv8Heir68Mvw4Uf8lg3SuvVzdbm//XbJjg1GSg3RQ4BsqiHcsrPNhScGH52DkfhCu/4B6jMz5xVhyvVolyic0zuNoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vt3yc6CV; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vt3yc6CV"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-50d6b393d60so9001cf.0
        for <kvm@vger.kernel.org>; Wed, 20 May 2026 20:49:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779335374; cv=none;
        d=google.com; s=arc-20240605;
        b=co8hR5/f/JZk65809DQh+ekCwOfhj737iELasUkIyNgEgVna+KYEujAkoL7LmiGhRN
         r4SF8Pk5AadRJbIofHsE26rZkcsoghSxGJnFzk5TQ+brSu9s4/OeXivxe6BwEdNMX+dB
         WnkYIgUBuGcfdBY8ybyUBEHavT1DbWzq1mWlf1KHSRxsRpgfQGImMSVxE+vf1R178Wzu
         MT6ldhVLNZYcFLXoVXmsCN47aodWYBv4eO1NEenQ8m9Opd9iSXF5hnY5ybLYpBGHeeyU
         zzvbYZNdmW+hNTlyrqWaG3tiwjgsKPXpF1FuLEMLCLr/WAMiB36D0Z2CxYbRohfQH0TT
         Udhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=B1qmBd6CsYV57a7wsuyvRdWAzffqjmM+Rz5NWT6mUuc=;
        fh=XskZpTNp3aLLJcFvgjbSYiMrQmUJEsvAGUaEHIakNv4=;
        b=SYlRYXuIcggXJFHKTQPCUBn0Bt/KAEert61cfq8r88urvhCJAMeSaDRsKXufgPnfK0
         gpheLReMziBgg6AsbgEsdTRSBwbEVM5r4f9RUsWh3u25/MbGCyx1A5+gvt9YEPKg8FZ4
         +Oq2e2C4OMpiJErMA/zhZWauize2g6LYB4Q0WvgxnX+6/f3Fqgcc6oD4DPEhjI8Rnzql
         XFRPxsA7xvpPpRXp/veOSGUJmnk575uld6AqNwudajXTksahM0ztNIm3kVvqDGvymbvW
         E1/qsX2BIocqF7hVrYHWyncXa9LdYmZr9ek3p/TSYIAXwWujKwaA9NBV5dff3Ok7PXj+
         zdlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779335374; x=1779940174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B1qmBd6CsYV57a7wsuyvRdWAzffqjmM+Rz5NWT6mUuc=;
        b=Vt3yc6CVONlNtbBeota7aD9LHSGYtgnxHBpf8Uk832vqkG8kWiZAJz6f6Tu84mlGPc
         4ed/xs5/BhbqVZxc/hI9rl28GWpN3YBlzAEN5sqmBYiVzGS5eMp9EH71wnPW82eBI2of
         QlLnqmUH1qOIob6lypZ5nkblLWC8N7luNgt0RN5owwAEuOnvYD6T1Nx8wotxeQhyripm
         SEfvtIuYx0iem0A7uH/jpkL9j/6P6L2dAuT9CpB2TQBfTIa86duysux41JEqXgeP87hh
         NvcgWW9RvVWWVuAdVlBzQ/+WQ3XVCUq8hcub6VodRdYfYC0t9qqkJKKDUDdmM/Xlfcxu
         wwow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779335374; x=1779940174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B1qmBd6CsYV57a7wsuyvRdWAzffqjmM+Rz5NWT6mUuc=;
        b=R5e1CgLl4fQYCykwuv9vlCY0/VletG/Sre5TX4MlkxbbyAWE+ifDpiGNMQhVK2YilL
         H9s9I1qOk7SLJeNFf1N+NDxF9w1Cv85/SXvP2fGUvkgMGoyPbeLA8XusD8npvXB6H5K2
         eu21CzztxcUPCSGVh6XqBHfF5iqibCyuHsZtwcFQfDJF9aN9xheDjl6+ASInKNLQ98Dz
         UVAYwXIczJoSaWH+pQpFMpFtDXdLN7tE/YYaUDWyIC2iUsThtLH5FqBXkmSRncVDzubk
         3sgyw/PyWFpGjC9zlwcOvGV47AETtf3HMxSrE2AY+nLeisdDcqRLpcrm5kCV5dDU+VH9
         7Tqg==
X-Forwarded-Encrypted: i=1; AFNElJ8vnlriZQA/P3XupwcELBKEDxj7Ul4dArzuTkjpZo12FFJrL6huKnUqVMbXQPs3b8NotsM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr0cfTicsMYfhbs5TrhdgnqdecVfMxPo+k6lXiIaQ8wAlbdMy/
	e23rYhWzIPBpOO/OOlqMLYnnZJE/qHRGAGuTofVuf586AzRHu+dpI5Yvt3y2cVqizvY6TeY0JB3
	QohOFwjIAyQW3YDC31ic/d6PLAE/2gGnF2j55QvCzgdytyTN1SScLsq9NQRI=
X-Gm-Gg: Acq92OH1jni215vZ6+yE9uChmHfLGAZswZwAsa3Pa5G/rbSzaf7Fp6Q7DkCQwTn+P28
	GB95GEb0S3z23zoF29EJJiF/Lo42FlMOtkTwGIqUwYyqOtAZRoIyNcNFIsTjTHfUawvhW7dOId3
	UzJu/5ImwDymArB758znKYofG0nRCmk7TAYubJBtcAZDct+o8vX00MIaIGx498szTmPV2qo9oBS
	I7zmvbyRnWCeYkj69jlm/kEgX5jp9GRpcHZ5Up4P9k9hzDCYu3z0CKX3/WqxIWR7WO8gyb8M9XA
	J9p0GEdF6uXGuuKput7usA2G1weP
X-Received: by 2002:a05:622a:4cc5:b0:516:4f62:85e8 with SMTP id
 d75a77b69052e-516c552713emr4320271cf.19.1779335373860; Wed, 20 May 2026
 20:49:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514173449.3282188-1-rananta@google.com> <20260520125354.2e028b46@shazbot.org>
In-Reply-To: <20260520125354.2e028b46@shazbot.org>
From: Raghavendra Rao Ananta <rananta@google.com>
Date: Thu, 21 May 2026 09:19:22 +0530
X-Gm-Features: AVHnY4KgzM7bdCVNXJ-bEutq8PSATbXFCM7-DWURJaNecJOqaJz3xIil0Q_IlMM
Message-ID: <CAJHc60zA8Efs41dLj_JLaeVun8toTxVQoRPoPWNW2oJH-bQ47A@mail.gmail.com>
Subject: Re: [PATCH v2] vfio/pci: Use a private flag to prevent power state
 change with VFs
To: Alex Williamson <alex@shazbot.org>
Cc: David Matlack <dmatlack@google.com>, Vipin Sharma <vipinsh@google.com>, 
	Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alex,

On Thu, May 21, 2026 at 12:23=E2=80=AFAM Alex Williamson <alex@shazbot.org>=
 wrote:
>
> On Thu, 14 May 2026 17:34:49 +0000
> Raghavendra Rao Ananta <rananta@google.com> wrote:
>
> > diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_cor=
e.h
> > index 2ebba746c18f7..f1451ee4744ac 100644
> > --- a/include/linux/vfio_pci_core.h
> > +++ b/include/linux/vfio_pci_core.h
> > @@ -127,6 +127,7 @@ struct vfio_pci_core_device {
> >       bool                    needs_pm_restore:1;
> >       bool                    pm_intx_masked:1;
> >       bool                    pm_runtime_engaged:1;
> > +     bool                    sriov_active:1;
>
> We should drop the bitfield use.  I still need to respin my patches to
> cleanup bitfield races in general, but this looks like a runtime
> updated bitfield without any explicit locking convention with other
> flags in the same storage unit, so should therefore be its own bool.
>
> If we agree, I can do the s/:1// change on commit.  Thanks,
>
Sure, it should be fine to have this flag as its own bool member. Feel
free to make the change.

Thank you.
Raghavendra
