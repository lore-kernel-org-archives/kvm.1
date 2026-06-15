Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D29411694;
	Mon, 15 Jun 2026 17:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781543605; cv=none; b=rmmkpa7GkuLWIP67PSuFWQJDpN2uajEX8G5XKF6uA0Z+LUF4/JkCIm6mdSlVamiAdx/8ZTELDmbxm8fxoLVN8gZ5lHt36kEjyRp2QgwwwllzD5jOiEogvjqKv5ogJDRJXIGqLxlrsqN/mSBcoHo7Dfp4H0IRvfq16J0skNS1AVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781543605; c=relaxed/simple;
	bh=vIvfN+UVP0a1jpNh9MZOKcnAduoJQL6vWVlu40op1n8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ouPQXVcBUMCmrRnn/UuKdsvyv7ocb+lXr6YcRKavBmN4KkQjdh1gxDQrAE//0BXYzMA1isxy/ESAa5cYLzfNRtg2XgrFtSJJJdlMWXpzyCu+zLXRgO98OVcsJeQO/y/flU4N50lWsjYZYwIZAEuauPrJDk8U3DClI5v7DnrV2ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=l0s8gVLn; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="l0s8gVLn"
Received: from pps.filterd (m0528005.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FFsDMl2417603;
	Mon, 15 Jun 2026 10:13:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=s2048-2025-q2; bh=l0uOK1Mg5WaFHaoF5tPX
	saTZvJO3YB5M5MPuUWRtdy4=; b=l0s8gVLnkwdTAPe+f3iIHKLWTKM9aVj+y488
	McbwwFU0wTbnKPZb7r7xqgMnikWDXqYPG89kXmqvgaPUKM39xUlHfZ+qaVrKOxpa
	aJPm9m+XJsS+WzOiELkZaL9aI6QE4uOXwYe0HIRTL8DU7zcmAWeTisexwHEus4pp
	0heAitPg2EW1jqok3T0ZnZq+tsADS9X93W9SfujSgL+e5yuLliGhrBGkmFe259qY
	0+QOrWyyJDf8JrxGvEXSBBamhfJ0JnUSLY9TVbfF5EBY2GjoXIlZt9XPEoSuvx4e
	9QIy/c4moKOZjQMi5dtT5aWNxe7GElko5qakVRzrodt8FwKn8w==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4esrsh6qys-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 15 Jun 2026 10:13:16 -0700 (PDT)
Received: from devgpu015.cco6.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Mon, 15 Jun 2026 17:13:15 +0000
Date: Mon, 15 Jun 2026 10:13:10 -0700
From: Alex Mastro <amastro@fb.com>
To: David Matlack <dmatlack@google.com>
CC: Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
        Raghavendra Rao Ananta <rananta@google.com>,
        Vipin Sharma
	<vipinsh@google.com>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Shuah Khan
	<skhan@linuxfoundation.org>
Subject: Re: [PATCH v2] selftests/vfio: avoid VLAs
Message-ID: <ajAyppvcK7ViJJRk@devgpu015.cco6.facebook.com>
References: <20260615-scratch-amastro-vfio-selftests-avoid-vlas-v2-1-4e4df462908a@fb.com>
 <ajAsJXWxRQtkIaCf@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ajAsJXWxRQtkIaCf@google.com>
X-Proofpoint-ORIG-GUID: EecBBOisbfPpexi8taZFo2apUp0SC_UL
X-Authority-Analysis: v=2.4 cv=DOO/JSNb c=1 sm=1 tr=0 ts=6a3032ac cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=jCddH8ec0KUNCymVuxII:22 a=bC-a23v3AAAA:8
 a=FOH2dFAWAAAA:8 a=1XWaLZrsAAAA:8 a=r1p2_3pzAAAA:8 a=VwQbUJbxAAAA:8
 a=ag1SF4gXAAAA:8 a=vn35S1QI-jAAMeZZ1ucA:9 a=CjuIK1q_8ugA:10
 a=FO4_E8m0qiDe52t0p3_H:22 a=r_pkcD-q9-ctt7trBg_g:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE4MiBTYWx0ZWRfX5Z81KXGI4QGN
 3CaPq1MxzG40cOiC7i48hNkfn9Yy0WFj0fJ+3Bh14BwOV3MfzAksRTCcagnZ2qSJP8V/QxbREnS
 KggLF63QODF/achZu/Y0DLoiMJsrk7s=
X-Proofpoint-GUID: EecBBOisbfPpexi8taZFo2apUp0SC_UL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE4MiBTYWx0ZWRfXwZCD6kR1c6YV
 HNdUG7QOfwtVRUZijXDQJ6TLLItCTsBK6/072TZu9sz3FpOHHHvnoPcOAAcAn24Oz1x0n+ffH4e
 pDRtEiBtKiLRr8xWwZfKvO6JlXlzmEEB4fAc/hRoeQTJvT9/T8lS6tNHGKrvDLEaXexqO8N6+SG
 7jzhIuOteUbdLfHurYSr0R6wG1nc8i9hud2PAGI1Zxv0/+5PNW2BnOl05PGWJhuvOSHnWxNiDrR
 UbEklv/L3BV1kX6IznQH3QULkS/Cp2JImdlfIps9mKhxUpFx+VMeaSUgjRjkjXj2iW6wECgSR3l
 6V0tE8ETQfue52O67wSynUf286uMxfuwTCjhKvkHpBOSbqA3jrNrJs6/lw0TBuHcywiOC0VBA2i
 fllktrfYoAvYg3g+JhMmbXLhQkMZrutRLdJHP4yykKjoQ6OlyExWraX99hAz0hh/aNusKIB0cET
 bZ19RLUOxnCgPnNbdSQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_04,2026-06-15_04,2025-10-01_01

On Mon, Jun 15, 2026 at 04:45:25PM +0000, David Matlack wrote:
> On 2026-06-15 08:47 AM, Alex Mastro wrote:
> 
> Please follow the local convention for shortlogs:
> 
>   vfio: selftests: Description of the commit
> 
> > Allocate VFIO ioctl requests dynamically instead of using VLAs. GCC 11.5.0
> > rejects initialized VLAs with:
> > 
> >   error: variable-sized object may not be initialized
> > 
> > The replaced stack u8 arrays also do not guarantee native struct alignment
> > for the aliased pointers.
> > 
> > Fixes: 19faf6fd969c ("vfio: selftests: Add a helper library for VFIO selftests")
> > Fixes: 20face8c75ff ("vfio: selftests: Add helper to set/override a vf_token")
> > Assisted-by: Codex:gpt-5.5-high
> > Tested-by: Vipin Sharma <vipinsh@google.com>
> > Reviewed-by: Vipin Sharma <vipinsh@google.com>
> > Signed-off-by: Alex Mastro <amastro@fb.com>
> > ---
> > Changes in v2:
> > - Reverse xmas tree variable ordering
> > - Link to v1: https://patch.msgid.link/20260612-scratch-amastro-vfio-selftests-avoid-vlas-v1-1-ba3acb635f0a@fb.com
> > 
> > To: David Matlack <dmatlack@google.com>
> > To: Alex Williamson <alex@shazbot.org>
> > To: Shuah Khan <shuah@kernel.org>
> > To: Raghavendra Rao Ananta <rananta@google.com>
> > To: Vipin Sharma <vipinsh@google.com>
> > Cc: Shuah Khan <skhan@linuxfoundation.org>
> > Cc: kvm@vger.kernel.org
> > Cc: linux-kselftest@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  tools/testing/selftests/vfio/lib/vfio_pci_device.c | 28 +++++++++++++---------
> >  1 file changed, 17 insertions(+), 11 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> > index 94dc5fcecbeb..c65d5ed33e51 100644
> > --- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> > +++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> > @@ -30,13 +30,12 @@
> >  static void vfio_pci_irq_set(struct vfio_pci_device *device,
> >  			     u32 index, u32 vector, u32 count, int *fds)
> >  {
> > -	u8 buf[sizeof(struct vfio_irq_set) + sizeof(int) * count];
> > -	struct vfio_irq_set *irq = (void *)&buf;
> > -	int *irq_fds = (void *)&irq->data;
> > +	size_t irq_size = sizeof(struct vfio_irq_set) + sizeof(int) * count;
> 
> optional nit: s/irq_size/argsz/ (same for vfio_device_feature_ioctl())

SGTM

> 
> > +	struct vfio_irq_set *irq;
> >  
> > -	memset(buf, 0, sizeof(buf));
> > -
> > -	irq->argsz = sizeof(buf);
> > +	irq = calloc(1, irq_size);
> > +	VFIO_ASSERT_NOT_NULL(irq);
> 
> Could you add a precursor patch to add a calloc_assert() helper to
> assert.h next to ioctl_assert() and snprintf_assert()? It looks like
> there's quite a bit of code that repeats the
> calloc()/VFIO_ASSERT_NOT_NULL() pattern.

Good call, yes will do. Thanks for reviewing!

> 
> > +	irq->argsz = irq_size;
> >  	irq->flags = VFIO_IRQ_SET_ACTION_TRIGGER;
> >  	irq->index = index;
> >  	irq->start = vector;
> > @@ -44,12 +43,13 @@ static void vfio_pci_irq_set(struct vfio_pci_device *device,
> >  
> >  	if (count) {
> >  		irq->flags |= VFIO_IRQ_SET_DATA_EVENTFD;
> > -		memcpy(irq_fds, fds, sizeof(int) * count);
> > +		memcpy(irq->data, fds, sizeof(int) * count);
> >  	} else {
> >  		irq->flags |= VFIO_IRQ_SET_DATA_NONE;
> >  	}
> >  
> >  	ioctl_assert(device->fd, VFIO_DEVICE_SET_IRQS, irq);
> > +	free(irq);
> >  }
> >  
> >  void vfio_pci_irq_trigger(struct vfio_pci_device *device, u32 index, u32 vector)
> > @@ -118,15 +118,21 @@ static void vfio_pci_irq_get(struct vfio_pci_device *device, u32 index,
> >  static int vfio_device_feature_ioctl(int fd, u32 flags, void *data,
> >  				     size_t data_size)
> >  {
> > -	u8 buffer[sizeof(struct vfio_device_feature) + data_size] = {};
> > -	struct vfio_device_feature *feature = (void *)buffer;
> > +	size_t feature_size = sizeof(struct vfio_device_feature) + data_size;
> > +	struct vfio_device_feature *feature;
> > +	int ret;
> >  
> > +	feature = calloc(1, feature_size);
> > +	VFIO_ASSERT_NOT_NULL(feature);
> >  	memcpy(feature->data, data, data_size);
> >  
> > -	feature->argsz = sizeof(buffer);
> > +	feature->argsz = feature_size;
> >  	feature->flags = flags;
> >  
> > -	return ioctl(fd, VFIO_DEVICE_FEATURE, feature);
> > +	ret = ioctl(fd, VFIO_DEVICE_FEATURE, feature);
> > +	free(feature);
> > +
> > +	return ret;
> >  }
> >  
> >  static void vfio_device_feature_set(int fd, u16 feature, void *data, size_t data_size)
> > 
> > ---
> > base-commit: a26b499b757cfc8bbff1088bb1b844639e250893
> > change-id: 20260612-scratch-amastro-vfio-selftests-avoid-vlas-395eb3dcb3ab
> > 
> > Best regards,
> > --  
> > Alex Mastro <amastro@fb.com>
> > 
