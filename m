Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795451263;
	b=RLcFvEKNOxdpaujTvn1miTUwnZ3tfLuG4J9CdPrQDUfq2W/Ae6GMR9OsQOLejKnzgGP1
	 ojkXnC82tuDDQeH5/npkgDsfL9kVSgHkgxZMKAlhaWbrjgkW1OR9IJHI9Eb5qdpwyyepJ
	 kofsAlA3xgT+mWY0i3nWP91sacln6I/1uYxU7qdTQAx9iU1LlfsVwPakJOWJdGFSfq1eg
	 1yVQsvh1MSQzUfIvPcUiaRM7voNxIG9WAZaJjM821dEKFkb6B/BIDNkLVcGdfJzGgiw+/
	 TR0Pt8yJQZynLvErkRUw2G/etIRCPU+GwE0V2hSdKj3TjF1cE6aQ7R/q0TM8sypu91w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795451263;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=vB3psAisz6oN/RnCKU/w6FpM8F0jva1/kUicZCF7qx4=;
	b=qmj6vXyaFb/IUHcbB3bJeuIMMzHCvG79OTHOB6vTOHlGnrJIDJCHnomAvjU1iSMOukoh
	 aTl7V8vQmqWxP9mLHL3dI6S09fyVBEnLnJeZWRbMeFP+3SDRMYWHB0yPFDmYvaJ+F3cfM
	 IircFKyXP0OYiN4uoH4qRwGLy6+YSy59QRKQtHM4LGkqg/UE+7Our1osj+1DxlzjOudT6
	 ahayAa3M5HA+5JlyY+7XvAoScdxNscpAF8jCFgwIP6zMQT4w7/MI+t+NlLe+1KRhcZh7b
	 LoH2I+HuMhqY498JUHutiCNVsOLWqfvfHMt3Ol6UW1qjtMfCXVfFMQOkFcdoAWQfY+w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jLLFt0C1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.175
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818F2606A31F
	for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 16:27:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 818F2606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jLLFt0C1
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-53644b28706so59451771cf.3
        for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 08:27:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795451262; cv=none;
        d=google.com; s=arc-20260327;
        b=fvtWOhVqXZ97bkXcga7zI8erRroWXhm/z6ERGSaka+b2k6PDFcqgxVe0l45Lxn768H
         nKfTftOD+wiK5yq0Mi0aoJArAHweIQH2MA35245+k1669hT/MB0GvpUADcYbJjfYnEie
         DplHtNC44uy1atT514h+ULsJOUfzCJTydsCi1Rbda7LeOyCaJjXbwtMqpTvtCnReBtzc
         AkrxJ1I44evC9wNL7ITJmwUZWbDMMhVsMk7lNn/iABobwu/kW+PDqN5OzaNapeZHLEvT
         apKZ7TZ5nahFk0GiiiolV6vJ2wfTjux8hp3Fbk6njExa7LLvrtguZQQ93yG8eCrSLQdS
         olcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vB3psAisz6oN/RnCKU/w6FpM8F0jva1/kUicZCF7qx4=;
        fh=zgE4D3jfHHAY5s0m0mEWzoZvqITokOe1xXFrNvtaZOo=;
        b=kz5pqUJxWkua3sNUu5FH3VgwQUzr54u5o7MfT1nxBEF/QweejKpU05BBKQBFpl2V2W
         EiyKhKJVNC+8zumlnQtZfI30RScY99+RTCOQjxminZa7pV0LJ/v8PCBDIi7yO5pvcW5s
         JGoW2yujVofb7jFFexZrU8KFty4ov8Tz25ADHHYpqJ2dsofPK1V1N4QXtd5uzsjVmKTt
         cSssg7ePjQvQ2sM8ZLftiysltdt5AnCDscub6C0vfq+ZhNqZBlZ+F521xJuOjeZEeo+E
         IiSTWDGCrDt17jSGvpbvzxrhdhLdWX8Aiej4Xl55lqcnsOUeqzCp+CTw4Fv+97WpLj7B
         li8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795451262; x=1796056062; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vB3psAisz6oN/RnCKU/w6FpM8F0jva1/kUicZCF7qx4=;
        b=jLLFt0C1tUxuzmq1/dAe3AizY26009ud2oEFFwgb6/BOL4L542gMsBL3pJRtL6iq2v
         Uc+MNqdDJE4FLmnWZ5bECDKnpt1Q354qkZK0NJPf6wxjDXiZOGBcEDbFfNH1dHefJY6J
         EGcBbEhfeaybNqvnV22+WqA/6NFra4pzNtmFzJUiFu4dJnj7AwIEPtPDA2VLYLIb7/u7
         DBeRwxnxHiZaSDn0mApye8nobpijGcq3rnyNXh7/3Rmnad1TQN+aJFSvCo5EFSJGjAv5
         sMi1AvSBUjj1jKNN15rILP7IgC7bbcc5qGJ2ojhuLvC3KO8z6/MVUPjHKsYxeG4Rks9E
         ZFvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795451262; x=1796056062;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vB3psAisz6oN/RnCKU/w6FpM8F0jva1/kUicZCF7qx4=;
        b=ldh3geJhERar4pObFr2EN2WCDgZKs97pjDFeJFbBz+peti+J0gjoL9W/VDbYip1WbC
         kQ3ThpSvtYw+uQPQryzHSk2QNLSRpOxAGXaqW/W4gmlKjLI7bZ07HV5dkKQwWVivt053
         VtuG9v1s+x8WCZDBPnpGctlAnuNAhXm/bAPeX7zrc4QTjWP3wonMA18CrpmpMvWDFJ3O
         JQPJABDGJdgEMawWt59BtNBg8TPMG3xuvm/xzQZ4JnotmDZLQOZgFoyP6eU9DJN4Dq7F
         OLhqAKOllgd9tFYGuK0GMoy9nC1EV3Wau2BHfndq7tDPu5huRHiUtQAMBihyayPnb4fL
         mKuw==
X-Forwarded-Encrypted: i=1; AL+hErFSpUcn2UZ5F9b0mXtDwX2Gh8vYDRDsfm4Le41gEDa2iGDklOtG2A25NBLqN8gNjb/OoJ8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/qeqtu0TFwViZDHSTBTQ8Qrx0z4rokVTbMgHibnQ5aapxuqxga
	uQ/C3n6j8mg0o5y5+oBMTtFGjLgN6kj4CaChJWkNSc/YatEESblcXyzWB04UXKoqJneBlHYSQsH
	xlAHCoiiAtMZDJG3T5fhjmsN0m7sKiEg=
X-Gm-Gg: AZFdTZc12LSHlx0KZgddeU9kQ2xv/uaWp4/4n7zNzFpd2JJ1XEhuxHSXQ1ki5/UPYOI
	UJOmjyo3BTuBrMWJZ64GZvnE6YGam0i31/XH6ayN8ogTXNMbyLKLOTrS1OHpDCrb+yYnofs8AZq
	nCNUnIbbzxkiM6849FxR/R1ufLrrhiukokr9YGcSsQbKw7ULanrI8ZE9cKA+4fTKrSp4ga2APRB
	XPUCpVGj2i0ga+LzJgy7p4dWxc8mJHjTEqzTYY7K5K65t3AhGgTcQd/XGq586z9a+bz996ubaXG
	J4uW7rgBbPhvhB4QvsdqnAyTMHiAn9zzX01mMBbFrRbe1mY0b444RyJbdC+HVPcHcCkaluHDR5t
	uAdcKITNt7qAK950L8U2855+QbhXSk7LE1mH16l1SuqRoHnW4YsyQGEi8IzBxn0kJ69072ALFB5
	xd74T9IDQvONHl+pS0keclWj4tcLTsy7nhDthIYzgtwI2jaAlrX44NBaPV+xc=
X-Received: by 2002:a05:622a:2609:b0:55d:6ac2:ceef with SMTP id
 d75a77b69052e-55d768a3013mr222786721cf.2.1795451262262; Mon, 23 Nov 2026
 08:27:42 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029192032.1325629-1-thepacketgeek@gmail.com> <CADvopvYQDLx81gDFNR8MAg9E010K3yJNEByAwawQHFahRYiXzA@mail.gmail.com>
In-Reply-To: <CADvopvYQDLx81gDFNR8MAg9E010K3yJNEByAwawQHFahRYiXzA@mail.gmail.com>
From: Matthew Wood <thepacketgeek@gmail.com>
Date: Mon, 23 Nov 2026 08:27:31 -0800
X-Gm-Features: Aa3M54or1N6jhbFLhNPl69WhIQyJD3OfJsyAOFV4LpBHefX5dDm7mu41jxBLzCc
Message-ID: <CADvopvYBODrxGbO1B6YRWeyAanBPd8MPa9Obat0SuGD7HNxJYQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] PCI/sysfs: Wait for config access lock in sysfs attributes
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, kbusch@kernel.org, 
	Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 11:35=E2=80=AFAM Matthew Wood <thepacketgeek@gmail.=
com> wrote:
>
> On Thu, Oct 29, 2026 at 12:20=E2=80=AFPM Matthew Wood <thepacketgeek@gmai=
l.com> wrote:
> >
> > Many PCI sysfs attributes that read from config space are using kernel
> > accessors that don't wait for pci_cfg_access_lock() holders before read=
ing:
> >
> > - serial_number
> > - max_link_width
> > - current_link_*
> > - *_bus_number
> >
> > If userspace attempts to read from these attributes while config space =
is not
> > available (e.g. during a reset) there's no telling what values will be
> > returned: All ones, zeros, or garbage.
> >
> > Looking at attribute addition history it seems like this was an oversig=
ht
> > instead of a specific decision so this series tries to resolve the attr=
ibutes
> > above to match the sysfs attributes that do use user accessors: config =
& vpd.
> >
> > Patch 1 is a prerequisite for the rest of the series. The kernel
> > accessors these attributes use today skip devices marked disconnected
> > but the user accessors don't, so switching over alone would make the
> > attributes start sending config reads to disconnected devices. Patch 1
> > adds the same pci_dev_is_disconnected() check to the user read
> > accessors.
> >
> > Note: That check also affects their existing callers. On a disconnected
> > device, VPD reads and writes, VFIO config reads, and VFIO writes to
> > PCI_COMMAND now fail with -ENODEV, rather than returning ~0 data or,
> > for VPD writes, timing out with a "firmware bug" warning.
> > pciconfig_read() fails with -EIO, and the sysfs "config" file and
> > /proc/bus/pci still return ~0 data.
> >
> > Changes were successfully tested by continuously reading sysfs attribut=
es
> > while a reset was issued.
> >
> > Changes in v2:
> >   - Patch 5: check DSN read errors in serial_number_show() and return
> >     -EIO instead of an all-ones serial number
> >   - Collected Reviewed-by from Keith Busch on patches 2-4
> >
> > v1: https://lore.kernel.org/linux-pci/20261025000836.58294-1-thepacketg=
eek@gmail.com/
> >

Hello,

Checking in again on this, is there any feedback or concerns or do
these changes make sense?

Thank you!
Matthew
