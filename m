Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799F8358378
	for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 01:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789609784; cv=pass; b=XJ9fmT3eA67ffP41kac6LBgPi7S8TvU9VbdL7Zt66RPsQTJEgN0WZOm1b7y8BlzaHDns8TomZ7LDqGyTGwm6Gq5OyHoKk+Ed4fd6LbyR4dD3ReBkwO57rsdkLbe1pC4eOaSaATCWYSbrFGT6fJ2e5d4+8eNBF6+9kPMPoHpK8C8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789609784; c=relaxed/simple;
	bh=4vvuCAg8LOYwCkFNxLubS5odZ0quKkv2reSoFIokHEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rxhGW8RZJZhNxRNZzxONH5acBmKXpx4Ye3+wSNhZpJDd4qCHai5XR0lgs65xxgreKUeq51Fe76VUwT5vd0i8gaW93ShG5YSs5kiEdbqb6XrkqiYsNFO6h0T4vCVzNUnHVgsaj3glZhMlri8BFuGdpyy8XLEa6StxEqRkmHRQf/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ia5cs1FC; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ia5cs1FC"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-52fb7692a57so2438141cf.1
        for <kvm@vger.kernel.org>; Wed, 16 Sep 2026 18:49:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789609781; cv=none;
        d=google.com; s=arc-20260327;
        b=sApvBSwikerl3735K6KexbjUutbsX1I7VcBw8uRhHlvkoKF1YbRpwR/YasqHOD4/fV
         GFkpBCjyQkanUD5DOXVjA7+i/liqhwtUkLS0npt07x8w25R8S1hpugadurMLAB2/QJKz
         iqhBVL5fhocest1SCYfAmXfgRSTOP0V9AnO02gv/eScqFrAHFRs4qtvzUqkwBvKMnN8t
         UcC6+McG3ClG3EQ3oguWdfMj3NWSAAls/fdSRWwFNpIaT8+1NLohrFIJhEzTCESOx41R
         TyaoGR7Z5J0oA7vzNQMtw2u7/F/TSy1E9l0IcgugG/qDlunbA4R6NCRao+ZyavOjgfdg
         ceSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ijmEvQZ7YCTIw8TR2oOyYMWmdXBKTEydSXSQjwrQ2VM=;
        fh=BE66eFjeSR0jpaglN7VyamzvTC7l3MkXRa92l8dpvCQ=;
        b=GwZD1EWaxKIkfThu9ykpT+9CPZgpXfITmQObVvi6C0koy1cjnZeq7ntOfypjgUB8sm
         Zw2gUw9B4CmXMW5Eb/Q2oMwP9y08F1GIu7EN67oDQOJPK5I+ulmBPkD0qrzJLTPFK+SR
         +uSUswSmoillSRHfoWGWGXdZhkeg7Mza6jzAHMgkkFYfUW8I/VI/KRKhWVt8IMpveKNt
         KE8Q2hI8vmjsddPCe9YZWgyKAOy84o0riuA4Oid30ZSalgIcuBnHmVy8B1Pv7gPHU1Rl
         ObMGY4gTf+cq65eR5l1IKvz9BViRGvuuoziTeiINv2l+ROgmAsdGtYT8Eavqr45kSgPh
         69bQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789609781; x=1790214581; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ijmEvQZ7YCTIw8TR2oOyYMWmdXBKTEydSXSQjwrQ2VM=;
        b=ia5cs1FCjeMPM5bwFeoDaGEblifSYhLt/DQ4TrEob+Mwx2yBejR/CX/ufmzMrFORKM
         AUdN1EuTp/TUCQiskjfP5Ipx0diLDtPUQKXknYPfLBm9RdJwVhMO8feEQAh5BPvnMSSc
         0XbuFvxRceTjAvxuu9TA5R3DD59ubE949JId861gLOO+Nmp4S+f4md0+A7wmVE+81Yzj
         1uMlmnqgz502nCSlidEg14/ZJkO4MAW7QAv7mDTRKQ09XG2BAKYjVh6RU272CENb67/o
         qXtZ6fXvedbC5kyMaIxnIoRGde28fFbX7mkDFUWHreVPym3zXZK3Nmp8Kyln8Vh5iltl
         A4Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789609781; x=1790214581;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ijmEvQZ7YCTIw8TR2oOyYMWmdXBKTEydSXSQjwrQ2VM=;
        b=jXIfCpVnY9tNSCj44LJWBiILPHc3OFm+1NTpVYgkZ6qQDra3uXDE3lUv04TrIeAmWj
         IyG1RhOAHoQFwon1kMWDbShJl1jZl61eViBrMIOsM1GV3IdT6g53cPioE7MgdO3/yx4M
         Mrm9jxo1KVxvlAMW5CConQjRCgEqsykLFoNP6Lu0dwxD2hoMxs0pxCNWrh+v9O6QYi7c
         j+EA+K2NflMkLxiO+Ou/uHP4tZGVB/x0QtUgqksqRtN7ifIvV5ImuBKSsZi/NpdwiLnl
         +vOH2V+dKWNWpg9Hj49XT0cDmg54Im6xZtZEMSASaOb8HeSnzXT1Uedp8KS5mbMPeDuw
         CcOA==
X-Forwarded-Encrypted: i=1; AKwUvBzCQ9v0bgS/+jhmcb1s94STFRrC6jc5TZTJeQ1oIFeKasbK/UuuWqXm8hYTIQmzzS1QIkM=@vger.kernel.org
X-Gm-Message-State: AFuF++nZ982JTNjDUQwfPZYoII6PMNK31JmiajRAlVhuAOnnkPZQFhHr
	DcGNZVaaMePkTF0WsMZHRKmOi69a3Nol3Od8Fw7TjvzsKXVGjzDSFAkGOpWnKTjd0jydj0rnGfE
	vYKCoyMp5oP1lgF28CGbVZIOCLNgY3C4=
X-Gm-Gg: AYBFou3eXk8DNG9yCPX1r2zQ2s3qv38DbawtTjphm5pMJlcrK2gkdoeApcX7F3DE6Lh
	G1mxi9mtwIXZTJjTyDSJZKbCK1H5mTKOTuUYSyt1TOpYLizf06H+FElcwtVfAYr899mv/6GjG6L
	rrf2E5tAVllAcGfX0NwyeyCxL7CIoMOb82su+iTOBXw40rMKctuc2vu6FKlU/ykCMgUn0NZs75a
	rYrdvK16x8QYnaqkaYLM3aqg2AYpxu5zh/z/3+AuwOpEUwBA2LRHgvwETtR5XAKvrFRpshSp3ll
	rKM0fXH5LnDgaHCGyxlSTVSV+dtzXORqXRprdwTeOk1CwlLas8KQNdgBWWkGO61W2It4KKry7KR
	yBcQJugg2UG+AVC0WSNEKJlxDJ/cUw5iVLNc5gYDj
X-Received: by 2002:a05:620a:6292:b0:939:78ab:3c5f with SMTP id
 af79cd13be357-93bb76e2fe8mr878910085a.9.1789609781431; Wed, 16 Sep 2026
 18:49:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260905081116.106613-1-zhiw@nvidia.com> <20260905081116.106613-13-zhiw@nvidia.com>
 <DLCRZLO06SIO.LS7TWQXIPZSQ@kernel.org> <20260914121217.70fa0d93@shazbot.org>
 <DLFD2ZDSK9YQ.3A4R66G8UJMD8@kernel.org> <20260915120148.7548a8ca@shazbot.org>
 <DLG7C7MLGSTC.2GSTD84WI595N@kernel.org> <20260916141718.GU3968357@nvidia.com>
 <DLGUPX9KPFKF.12CU304YAST79@kernel.org> <20260916162817.GW3968357@nvidia.com>
In-Reply-To: <20260916162817.GW3968357@nvidia.com>
From: Dave Airlie <airlied@gmail.com>
Date: Thu, 17 Sep 2026 11:49:29 +1000
X-Gm-Features: AcwNN1VXCeIhnNkZrtRydjWaxN4Qnt0jH2kObUrck50VuTkYeDZzVilcahg7zlk
Message-ID: <CAPM=9twda0Q9nj9E5AUCi4=en5tDA7ReBv8MV2Ftg-STwNbDLQ@mail.gmail.com>
Subject: Re: [PATCH 12/13] vfio/nvidia-vgpu: add the NVIDIA vGPU VFIO variant driver
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Alex Williamson <alex@shazbot.org>, Zhi Wang <zhiw@nvidia.com>, 
	acourbot@nvidia.com, yishaih@nvidia.com, skolothumtho@nvidia.com, 
	kevin.tian@intel.com, simona@ffwll.ch, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	aliceryhl@google.com, tmgross@umich.edu, jhubbard@nvidia.com, 
	ecourtney@nvidia.com, cjia@nvidia.com, smitra@nvidia.com, kjaju@nvidia.com, 
	alkumar@nvidia.com, ankita@nvidia.com, aniketa@nvidia.com, 
	kwankhede@nvidia.com, targupta@nvidia.com, nova-gpu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, zhiwang@kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 17 Sept 2026 at 02:28, Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Wed, Sep 16, 2026 at 05:38:21PM +0200, Danilo Krummrich wrote:
> > Usually, class device implementations can't make assumptions of the underlying
> > bus, because they have to work for any bus. I.e. there's no other way than
> > providing helpers and letting drivers do the glue code between the bus and the
> > class device.
>
> You should think of VFIO as a series of helper libraries. One of those
> libraries is "here are all the PCI PM ops you need".
>
> Drivers rarely need to customize these ops, they just need to wire it
> up to the support library to avoid a bunch of code duplication.

It's currently a library being used as a midlayer. demidlayering it so
drivers control drvdata removes that.

I sent the diffstat that covers all the current vfio pci drivers and
that didn't seem excessive.

>
> Stated another way - the very point of vfio-pci is to remove
> duplicated code from the drivers.
>
> So if we wanted to push hard on removing drvdata, and don't want to
> touch the struct device I would probably say to #define up a way for
> the driver to build its unique trampolines. It wastes a bunch of .text
> but at least it doesn't duplicate code.

+static pci_ers_result_t hisi_acc_vfio_pci_aer_err_detected(
+       struct pci_dev *pdev, pci_channel_state_t state)
+{
+       struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_drvdata(pdev);
+
+       return vfio_pci_core_aer_err_detected(&hisi_acc_vdev->core_device,
state);
+}
+
+static int hisi_acc_vfio_pci_runtime_suspend(struct device *dev)
+{
+       struct hisi_acc_vf_core_device *hisi_acc_vdev = dev_get_drvdata(dev);
+
+       return vfio_pci_core_runtime_suspend(&hisi_acc_vdev->core_device);
+}
+
+static int hisi_acc_vfio_pci_runtime_resume(struct device *dev)
+{
+       struct hisi_acc_vf_core_device *hisi_acc_vdev = dev_get_drvdata(dev);
+
+       return vfio_pci_core_runtime_resume(&hisi_acc_vdev->core_device);
+}
+
+static const struct dev_pm_ops hisi_acc_vfio_pci_pm_ops = {
+       SET_RUNTIME_PM_OPS(hisi_acc_vfio_pci_runtime_suspend,
+                          hisi_acc_vfio_pci_runtime_resume, NULL)
+};

is how much code it adds to current drivers, this doesn't seem
excessive for 10 drivers,
like you could obfuscate it a bit with some macros, but I really don't
see a lot of value in hiding
what is effectively just standard driver boilerplate.

Dave.
