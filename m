Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2254E3E2747
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 11:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783942102; cv=none; b=GiwZKZvXE1BO4F3eeV6KZhvf/UB1cXP/d+Rb3xpROYjb/h8yQZb8uWgAwb+epVf2fQEmFjimW7BIW8xzkIqvAL/wTf4wruE/yXTTweRgHyNuh5r2XvchiQ57iC6qSPyfNHsp1ys6h0h/Ss4vNxY+9FJ5DGew+LRYdS7tBx2wm3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783942102; c=relaxed/simple;
	bh=uHgFGVMCbWZ6QJREKIc2Cz/i2GP2gU6NvIIiskE/xE8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yf3WE0K36SbdFRVmiQ/38878YdfvojEAjDuQqpbFqvoaOsmDFyfQYhGJPBQqfJgg9UsAicPFnzb6r15qE4lq3r9848cFCMXL+ry5uu4nelwcuGFkbYD18j8PtQxCgDR6TXLMm2JI7CMF5I3/8vM4C0M7RCj0ClAT4MZFhgpilBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PMEG1vuE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Dtsd8oxp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PMEG1vuE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Dtsd8oxp"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D9R8Kr1122940
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 11:28:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	glcDPzcN1WLQPiWVuwh3aPS8v2o+iRyjebLoh+k+vl0=; b=PMEG1vuEmINSfp5D
	LWk7/yEHIXd33tPI9M+Vosex0ald//v3Q+TChukuJXz1036uS8xAc75BbrJ17WF6
	ORfPO5ehhd5FH23LoPKHou6eJqxYBaG05gTwsLquJHzcJOvdo1wDS9Ls4CZon4m1
	lSVD8CWf9rrw8wuICGHujLJQ1xWukkqBcNJbNKsFSv2rnHYMXEwNxcxUCxNP28af
	nYgBbft91G3jj3WQ8iFubDyerqR29yRejFVrl/jvg/KkEYRcFBg85IfNUS4z3Zle
	dSoqjsi9mqkRsLCHNwbvTVwkBzIIRB10ZlrWK3txcBN3GHalnp5SJuLOpE+0JjcG
	Jx20Gw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwda0du6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 11:28:17 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c1a9764f0so51713681cf.1
        for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 04:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783942097; x=1784546897; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=glcDPzcN1WLQPiWVuwh3aPS8v2o+iRyjebLoh+k+vl0=;
        b=Dtsd8oxplrGihwTiTi4E/2cNlWtBnZl8dWCDzsirtOKBrf7puwFD9mjVqCt1okuwzk
         CbY3N0TJB6DfBoxtbQdsTmGbuwW2pPbaPoA2xUl6smoHI59eR2mtukW8S2NRLOqqCayM
         hnNa2lG06HFwuJDThgNZrB9St9pNZC1ziMbSYbVI71XcNzAScGs9FK5KI4HWe5i7iB+2
         JFpkQRZhixLOkz/5vO6bymQgzQgJPFEBeCug92qR/jUafBCroplr/xySP5ZDhcr8NsQc
         5DNsrfN2UKSG5vIDsoinduOBMbkYqwUykSOA6Qrf/ktwO/EoMAyUdVH+/ROO5h7P53Kp
         7wDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783942097; x=1784546897;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=glcDPzcN1WLQPiWVuwh3aPS8v2o+iRyjebLoh+k+vl0=;
        b=GzunUBHluVyUb8EuDhyIoT93TiFgrGXM5fj8q2M6hQoU4bKngfKpEj1u+Yvtx6WIHa
         n96K6BtKpR4GdP431dok4F8vhe0XsvS4pJnKyztXzlEFqpuS6spAsUib9EfizXy5dfRS
         fcSa3e8Z9DWje/qhSI1dI/rPt+uWn9aS6i/+iqOYmLXZUtjt2eYEB60oUXsFYlli74Bx
         ByTILBgeDXFXulJQKPpAZQZXL4H7axYQJtmPu7UaifCsYC1H7E/Se5WAUymvJmyIRN0b
         sMRWjbGuEvxKoR9Qt4u01w8/VwbBzpsaR06id43AWjcMuX5uK4ZRqcM8+33sgoUo+1Cq
         edGQ==
X-Forwarded-Encrypted: i=1; AHgh+RoSJBNzBQJ73W6ByX7ONuOrzyInuabZSKPp8tn6Gf0zj/3LTaZjCIPLPVq9xML+kgb8eE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YynYFFOGu33pyURTjS1pMwwHY6i0iS7yO4nCOeq8/AmREx9ld8I
	zsfKIP3RUSG2vHdvthNTOMopkK6WuDONRGkangZ9FOylN2NcyF6wQdwr64KG0SeJyxjY7609QiU
	ntjPElYh6TtqlOfbzRWEdq4Zd438fF2FGrWA53Qp/QSaI68JBaEqYV6w=
X-Gm-Gg: AfdE7ckd4azQbcKJofavYMLzw7weiK+wAxoNkY80aPFE854P26GVZxbEHFxxKZ5+bbw
	Xgb2eXzsR24sW2ATr2SQbQh+QROLr8yHQL2ma1TXbEPGypZbMOEhlCzt3G1lIBMg4FrMhz1Oz0h
	VcUnJCMOB1lNgSdvJChUgM2t8m/kcQc3sTBfwCOWLPtmvsV+j5usZbdqRsOH55tnWyw15HteKPJ
	tm8XkSiRIe8uR8KCqu0Kjw+jivZaL6v3abRio7Bn1/ehVAjGvBJWUrzAm6GMatkwHhVT7bpfAcO
	WIMjTVk1/1MwbnRMjYzP7OTyip7PSEKiYL+c9XApDUWXnKYYFyQDpqBhhjiTwq6RLp1d3+mGM+g
	ZEn6KmJtfXDX95lEQuvoLO1pEwmim+2IUhucPYNlv9tMhwzP3fPIt6IKVMzeVzg==
X-Received: by 2002:ac8:7dce:0:b0:51c:f8f:13d with SMTP id d75a77b69052e-51cbf247d0fmr83784471cf.37.1783942097356;
        Mon, 13 Jul 2026 04:28:17 -0700 (PDT)
X-Received: by 2002:ac8:7dce:0:b0:51c:f8f:13d with SMTP id d75a77b69052e-51cbf247d0fmr83784241cf.37.1783942096953;
        Mon, 13 Jul 2026 04:28:16 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d83bdsm82553610f8f.13.2026.07.13.04.28.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 04:28:16 -0700 (PDT)
Message-ID: <cd0495e5-e63f-4931-ab57-fcf213cb164d@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 13:28:15 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] ui/vnc: use RFB wire types for client message
 handlers
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
        qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        Marcelo Tosatti
 <mtosatti@redhat.com>, kvm@vger.kernel.org,
        =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260706-fix-v1-0-4b83a70e9f3b@redhat.com>
 <20260706-fix-v1-4-4b83a70e9f3b@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260706-fix-v1-4-4b83a70e9f3b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDEyMCBTYWx0ZWRfXzA02FubWdx+A
 qTe1TktSKPowRBiLmQ8wlu07JJ25qscoP5CUVI3RtY4SnS/Hwl6dxJ8fiL3B4Tbt4ISlbzVTVQl
 rEIznRg8JFLqrbNKg9suJMDaCmEcI30=
X-Authority-Analysis: v=2.4 cv=cNbQdFeN c=1 sm=1 tr=0 ts=6a54cbd1 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=r0bVYnQz3-FgjroSeqQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: e84XG6D-R8mmShE6j2LEgIjW7A-0C_sd
X-Proofpoint-ORIG-GUID: e84XG6D-R8mmShE6j2LEgIjW7A-0C_sd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDEyMCBTYWx0ZWRfXwwqUtoWtbP0l
 4t3oex821G4Cc02Oqcz+z1qnr0Hztp/yiocE3Wlrce9ufAnnXbuifJwCwI15X35S1n90Pm2Q77p
 LbLFswBIUMkqby3vE6BYs8XB1AGrTTOcGD8U4J1HJRjG4kw9eiR+euty5owSlmOaKA6op47yJGo
 vQknB8MtBhKbKYSxfHQrLrQaNje6ylhkje3Tz9akm/fVGWk8H3MHJ3FHUshmp2st0mfTIBxWurT
 S0k/hSWeSb8eUPCLio1dccUxAWKAiSk3HOEBlLzSS0l4EueVcBkA+cRZ7HsWht3PxYj1rRSUuXy
 9v2kJtrRaNF61yTmh3L8cW2Ls0dKY/izydU7iZJ6TWtftxsNSQbrtW5MlbGsuRtNFWj1Hcktk09
 rs70z7wUcGcoBHy5De38W31hMClHyZsjfA8avFvqZC+V4mFS/3ngEdK2j1Kt5+e7LHWuvQXV+J+
 HEZAIu3N0M4fmyWwG3Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 suspectscore=0 impostorscore=0
 phishscore=0 clxscore=1015 adultscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130120

On 6/7/26 14:53, Marc-AndrÃ© Lureau wrote:
> Use exact-width unsigned types for the static functions that process
> RFB client messages, matching the types returned by read_u8(),
> read_u16(), and read_u32():
> 
>   - set_pixel_format: uint8_t/uint16_t for pixel format fields
>   - pointer_event: uint8_t button_mask, uint16_t x/y
>   - key_event/ext_key_event: bool down, uint32_t sym/keycode
>   - do_key_event: uint32_t sym
>   - framebuffer_update_request: uint8_t incremental, uint16_t x/y/w/h
> 
> Drop needless declarations.
> 
> Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
> ---
>   ui/vnc.c | 33 ++++++++++++++-------------------
>   1 file changed, 14 insertions(+), 19 deletions(-)
> 
> diff --git a/ui/vnc.c b/ui/vnc.c
> index 94a38242c56..14ce2816907 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -608,15 +608,7 @@ bool vnc_display_reload_certs(const char *id, Error **errp)
>      3) resolutions > 1024
>   */
>   
> -static int vnc_update_client(VncState *vs, int has_dirty);
> -static void vnc_disconnect_start(VncState *vs);
> -
>   static void vnc_colordepth(VncState *vs);
> -static void framebuffer_update_request(VncState *vs, int incremental,
> -                                       int x_position, int y_position,
> -                                       int w, int h);
> -static void vnc_refresh(DisplayChangeListener *dcl);
> -static int vnc_refresh_server_surface(VncDisplay *vd);
>   
>   static int vnc_width(VncDisplay *vd)
>   {
> @@ -1763,7 +1755,8 @@ static void check_pointer_type_change(Notifier *notifier, void *data)
>       vs->absolute = absolute;
>   }
>   
> -static void pointer_event(VncState *vs, int button_mask, int x, int y)
> +static void pointer_event(VncState *vs, uint8_t button_mask,
> +                          uint16_t x, uint16_t y)
>   {
>       static uint32_t bmap[INPUT_BUTTON__MAX] = {
>           [INPUT_BUTTON_LEFT]       = 0x01,
> @@ -1841,7 +1834,7 @@ static void kbd_leds(Notifier *notifier, void *data)
>       }
>   }
>   
> -static void do_key_event(VncState *vs, int down, int keycode, int sym)
> +static void do_key_event(VncState *vs, int down, int keycode, uint32_t sym)

bool down.

>   {
>       unsigned int lnx = qemu_input_key_number_to_linux(keycode);
>   
> @@ -2019,7 +2012,7 @@ static const char *code2name(int keycode)
>       return QKeyCode_str(qemu_input_key_number_to_qcode(keycode));
>   }
>   
> -static void key_event(VncState *vs, int down, uint32_t sym)
> +static void key_event(VncState *vs, bool down, uint32_t sym)
>   {
>       int keycode;
>       int lsym = sym;
> @@ -2034,8 +2027,8 @@ static void key_event(VncState *vs, int down, uint32_t sym)
>       do_key_event(vs, down, keycode, sym);
>   }
>   
> -static void ext_key_event(VncState *vs, int down,
> -                          uint32_t sym, uint16_t keycode)
> +static void ext_key_event(VncState *vs, bool down,
> +                          uint32_t sym, uint32_t keycode)
>   {
>       /* if the user specifies a keyboard layout, always use it */
>       if (keyboard_layout) {
> @@ -2046,8 +2039,9 @@ static void ext_key_event(VncState *vs, int down,
>       }
>   }
>   
> -static void framebuffer_update_request(VncState *vs, int incremental,
> -                                       int x, int y, int w, int h)
> +static void framebuffer_update_request(VncState *vs, uint8_t incremental,
> +                                       uint16_t x, uint16_t y,
> +                                       uint16_t w, uint16_t h)
>   {
>       if (incremental) {
>           if (vs->update != VNC_STATE_UPDATE_FORCE) {
> @@ -2250,10 +2244,11 @@ static void send_color_map(VncState *vs)
>       vnc_unlock_output(vs);
>   }
>   
> -static void set_pixel_format(VncState *vs, int bits_per_pixel,
> -                             int big_endian_flag, int true_color_flag,
> -                             int red_max, int green_max, int blue_max,
> -                             int red_shift, int green_shift, int blue_shift)
> +static void set_pixel_format(VncState *vs, uint8_t bits_per_pixel,
> +                             uint8_t big_endian_flag, uint8_t true_color_flag,

bool flag, bool flag.

> +                             uint16_t red_max, uint16_t green_max,
> +                             uint16_t blue_max, uint8_t red_shift,
> +                             uint8_t green_shift, uint8_t blue_shift)
>   {
>       if (!true_color_flag) {
>           /* Expose a reasonable default 256 color map */
> 

Including the (uint32_t) casts in this patch:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
