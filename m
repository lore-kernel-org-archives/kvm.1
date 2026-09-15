Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8C54825AD
	for <kvm@vger.kernel.org>; Tue, 15 Sep 2026 22:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789510896; cv=pass; b=gnjuzNgGH0DbEaTNXY4vklWizvJiP3wRATPHHa44IDV5NJehJYFtUAuUeN2vuP9quRGG+CDeyItuPxgL9j4lbPDcS0R8ITUP4fmVMMJLBxCBzzFQkVmpR7phbuGOEFW7idgYOyECLSG0SripdCFidfOg1cMDK089jGnf5v7V2oU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789510896; c=relaxed/simple;
	bh=zMEH3dKvgIFeOLNgenpgNKtSSPQyo3I2Bi4hOFPx7Sw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IZWNvWeqATms0ktY3JyEQJji2eg/9+f+J0W2KtekoN0JmJwNT74Fv8IzMAhep00FVm9jSIWxbj4kZUNjLOAsrPXkaAI1cQyNGjY8r0b5D+OHUtcwz96BtGC8IGONPSF2vTlRiowykvZ9l3/lZFXFS+JleMl1/lXB6tQhUIdTHK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IV/k2TQj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aB07AtjI; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IV/k2TQj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aB07AtjI"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FLZBRp721736
	for <kvm@vger.kernel.org>; Tue, 15 Sep 2026 22:21:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=hnJAniUUz5UpK0eAzqlFlmnyP+PG3E6KxIttKsrRd1w=; b=IV
	/k2TQjkUrsTGpshqW8f1AkLpzgE6WqJLnJXyVNHKYz8mozA+vLQbIOpShvI99Nvk
	BGk11nj45xZQZMebNdo7NiYw/EO7W5wcvHVc8eAkRKtGrNMclkKkbe3unomYvdUd
	vFaT1byqggr1zubtRjDzuTG9pECEQdOzFAiv4kdIU3d7CXM0IsQ27dhrP8NvQBkU
	TlOdMgPnM8h4FF25SXM2n03VFD94RLvjnLlaGSHHxie20ptztZeSDX3B4EelrzMT
	n1DLEJiB1mKEp0dVH3Si7JCiMZpC8ZcIigaByfbQDV2F2ANWVcL1rru5kNRyAlZ9
	ag1DWjYpUlLQQuGalXdA==
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqah9s4m8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Tue, 15 Sep 2026 22:21:31 +0000 (GMT)
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-4574f1cac98so10163382fac.3
        for <kvm@vger.kernel.org>; Tue, 15 Sep 2026 15:21:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789510891; cv=none;
        d=google.com; s=arc-20260327;
        b=bd+APIYJ7QbcKYegnUd6SZv2Ow+axJAFQQx2Pga0ClNpxB4ZpGe2BOL4f+llgozekl
         eljVyekX1kqOFRi+EvlGrEtcokNLMFu1v91dxqyXb8quXjBxIu25rESn56MsG1CDpPIp
         H9wMCQWKvZHU68JYz3dDtWX83w9E8YyIFmsSxZimuHHGHsKz3FugsSCsqejc/Cv24oHr
         X9t70oyrqs3og5HcPwhq06oLqPxFu0LbrpfUqezPQCNTFIBKldHTtC+LeEMtkaTpXixS
         bgE8uUek3MOCavK8gdG/pzZbFmMj8tO1OR6BU/vGzdxq6YUEi8aO+Vs1jOvz6VPQ3J61
         UV+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=hnJAniUUz5UpK0eAzqlFlmnyP+PG3E6KxIttKsrRd1w=;
        fh=mSvJIRP+yAChF5Tu8Usg5qg73Bkc5HsNLvTMRCFpvE4=;
        b=ZfmN2tuIeeGgRmO2vWTCjNuEaJEG/f6rTX8/6V0awhS41+GWtg2PXuxn56GKFk0c6I
         ViOPH/+q5ByT5rlS9P7Tttr1pzO0M3lp5Tw29tr4tc25PoZmiFqmxbAKxjNotqv9nsWT
         q3HHs4h8PdAaSYibu7CPo5XXkdaM5Kd2wMvuSJ49EqV6+5CoGJDtKGCi57qN5e+x+Ej+
         KN6MMHYq2AAZwDy8k1nbzJaq3FgQPKOj8Io7B5dA1ENx5XlbRRm4Qba+5aM3EYF+ruNS
         +MLsIZqbjSs2/OH8eZ7owa8tbd0+mwDQWFRUmcjH5yCgRJ17LiyCiowcLpS22XHAO8kV
         Ofdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789510891; x=1790115691; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hnJAniUUz5UpK0eAzqlFlmnyP+PG3E6KxIttKsrRd1w=;
        b=aB07AtjIKjPYRGcvBSuVUhbZlxd1+55zy/NhIuvnz19m7qssQTpE/4jhghs82a98Dx
         rtzGuCLITyYJpv6qqsfwRyWf2V/rvp/BavfnHKk+3jeYdHSZJCYDfk5x4efzm884vIfW
         UjGKSA8ySqC+bc1butY/HkkuCwEw+HH62Uipjk8j8bjqvTXRubAdUvP+c5BJvALTKQeE
         2MFV1Wjr7h5QJcQaotkuVTv077nzlClUSJUJjEEq6X2ukv02bdE+qejZx/+uCM7gRcPt
         xEQKVpHKyQ6abdYF/Q1vdcAj2ZFa315JGdv0g44dh8zUZEwY87qYbRStthdyfxwDukm3
         Mbpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789510891; x=1790115691;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hnJAniUUz5UpK0eAzqlFlmnyP+PG3E6KxIttKsrRd1w=;
        b=q9TcATJZO/VG/WyXiraW5zIouH0WshJW+Y8ddDTZe5OIhRxEgzoE1Qt2mNNrTGwj1+
         ZZ6QEpJjBUVMk99g+ldYmzBEtxpe5Eq6OHrWbwGXXOwTDNd+JdqmR6w6MscnEbb3ad6F
         TnbTeLiL1jTyXclHx4N6craVThz02urUP8+mspLRX55rHDMgCDCgBenYabNu8y5xCakU
         mXGFE9UY/+++TRWRN5D0HyDAKj6oUf6NuOTiG6UNvYbPzy7P5TgOqt5Jce9iCpJfIamp
         6ya0EZ+zZx7CUiqaQ47yAe6ae/pKsFIFmR/Rnlb6102U0bIzIlHkDnwACIV6C/6xYDax
         oC3A==
X-Forwarded-Encrypted: i=1; AKwUvBwBOlvxqZQUFsRefKEKBxoJgjUC/Igdgm3EN8fe78YVIR7zhBv8hL8+VrbKiw9BO1KfAi0=@vger.kernel.org
X-Gm-Message-State: AFuF++lbldlpgT24Pg/oDLacU21UOAwX1I0TnBlVwkyoOrl19qKYhB8/
	f4uV/K/kBXfGhePsuudwhYUMH0zr/v4BxBdO8O9JXl9PbIRLDppH86FpJhrpKaKi8ALLswVQ4Qc
	qIknqPW4z60r+Oi0kNWjjosNqNaSfLlkKxMdVi3RNHs6BZfR7RtOmJ7HmBm4wA72cICC/XT8ID7
	ueI3GTq4w1i1q4GR9FKYo/bt+ctJyDQg==
X-Gm-Gg: AYBFou2TElfwmw9+1HaZcxL2BCAXfa2rf9SYdCEggavNEvsjkBPcNdOKW/YHuODlBbY
	7ebqBkj+R6FEpEkdfavByYwtgyu8JRVx0XLEAD3G33JBjA/0s9rphebgPZ5+3/yZf4IzjfgxCn5
	h8AeXIzlEvmTxeir+b/oWcv/96x+kiQETSKoqLaaryLpJPxCD4h9pzWVAZ
X-Received: by 2002:a05:6870:30f:b0:45e:2de4:95f1 with SMTP id 586e51a60fabf-4847584c51dmr189759fac.2.1789510890851;
        Tue, 15 Sep 2026 15:21:30 -0700 (PDT)
X-Received: by 2002:a05:6870:30f:b0:45e:2de4:95f1 with SMTP id
 586e51a60fabf-4847584c51dmr189724fac.2.1789510890430; Tue, 15 Sep 2026
 15:21:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <CAHk-=wjeamU=_RYT9cR3dZJ2N-Teo-N1+aYh7jwhrB=iWXD0cg@mail.gmail.com>
In-Reply-To: <CAHk-=wjeamU=_RYT9cR3dZJ2N-Teo-N1+aYh7jwhrB=iWXD0cg@mail.gmail.com>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Tue, 15 Sep 2026 15:21:18 -0700
X-Gm-Features: AcwNN1UxxSxAxz0XPK7niSod0Tx_HsUs-C3mKdcqDSaFkh659BGkCorPygYZGHE
Message-ID: <CACSVV028AdnTYa6OKDeoJYCau58uTkKMgEdqTn7crNSV8QZxOA@mail.gmail.com>
Subject: Re: [PATCH RFC POC 00/50] file: handle files on syscall exit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, Jann Horn <jannh@google.com>,
        Jan Kara <jack@suse.cz>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, bpf@vger.kernel.org,
        David Airlie <airlied@redhat.com>, virtualization@lists.linux.dev,
        kvm@vger.kernel.org, kexec@lists.infradead.org,
        linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=BtkIUoX5 c=1 sm=1 tr=0 ts=6aa9c4eb cx=c_pps
 a=CWtnpBpaoqyeOyNyJ5EW7Q==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=Z4Rwk6OoAAAA:8 a=VwQbUJbxAAAA:8
 a=2Rxv5svHm-zNKBYa0PsA:9 a=QEXdDO2ut3YA:10 a=vh23qwtRXIYOdz9xvnmn:22
 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-ORIG-GUID: pmFvWjHZ0Lx2U3lyI4hNWwN7lZa_vb_g
X-Proofpoint-GUID: pmFvWjHZ0Lx2U3lyI4hNWwN7lZa_vb_g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDMyNiBTYWx0ZWRfX8KPampyskm/B
 BPYlUYkcc3VsEgGBELs8xYx8GbonUkWd7qGInzAoVnkwCaJ1mTxR5QXOFIise6Q1/fqJZwR8CK8
 a60vyT8k8V74tifjNySyOlPZUkkPdi93drWGTbupPXoY3GX7nGSlxxwXJOlX+DpLA3KArKSvsDv
 +Q0omTxc1DHID56KWXkJQBbGucgVr5KFi9DVbBYXwunrb/eBL2bQ/A2xq36z9jSlGJ/IZTwfNGg
 T1wm/OX6jUUfGU+2t+hp52m5xSFlj15pqzr2+2KfNKSyL/QNf8dDAMciTAzoAUgvl5YlHdh6RJk
 Zv/vHkWtrBasvwuhfQJvdk1eQA338JAGz5e5axFSKUvdyjN9okbjREp0FkSQXoJEEhXfe1jzJ6z
 PUPxIKvyLksS8JljsGiyOHaEAm+2j7EuFEFSdKVzab2gF04DwUej2afirmFn67YqfqAOpswmJTQ
 uxGWoP0ZgVF40JzVVQQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDMyNiBTYWx0ZWRfX+TX+cBXx7Odf
 JSdqHHvBkZlxWt2/wiFliF6kPY3gF8N48lbSAmg37G8TRWAbqb5ElYqfASfdH1MvhsJkVGz2XN4
 2z0KdPdgRyr6y6nMHegt5FjSCp+r2w8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 clxscore=1011 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150326

On Tue, Sep 15, 2026 at 9:02=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, 15 Sept 2026 at 04:31, Christian Brauner <brauner@kernel.org> wro=
te:
> >
> > TL;DR, this lets arch code handle fd install and cleanup. fd_prepare()
> > allocates a descriptor like get_unused_fd_flags() does and records it i=
n
> > a slot on the task. fd_stage() attaches the file to that slot and
> > returns the number.
>
> Honestly, I am *not* a fan. At all.
>
> I think this adds complexity rather than removing it.
>
> The diffstat tells a story:
>
> >  106 files changed, 962 insertions(+), 861 deletions(-)
>
> in how this adds a hundred lines more than it deletes.
>
> But to make things worse, it adds them in bad places: low-level
> architecture assembly code.
>
> Those extra lines are *not* making complicated code simpler. Quite the
> reverse. They are taking fairly straightforward "just deal with errors
> with normal cleanup in the place where it makes sense" and makes the
> *straightforward* case simpler, while making the big picture more
> complicated and subtle, and adding new code to places that are not
> simple and just blindly do somethign that makes no sense in that
> context.

With fd's it is more than just about error rollback.. exposing an fd
to userspace mid-way thru an ioctl is an easy security bug to write..

OTOH, "just use FD_PREPARE() / fd_publish()"..

BR,
-R
