Received: from outbound.st.icloud.com (p-east2-cluster6-host6-snip4-3.eps.apple.com [57.103.76.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA203A5E97
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 19:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.76.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780081419; cv=none; b=nxnecuyQq9u73nONFM4mzLBVIrsmeFlmh09bijrm0IF8sGyFHLfAqSzCrlds1aNv4hoxP+SBLo5pZmuFNSJ8wqLCXhFRuvGrhEBKp+hsuLQxsuuYjBcFLmmqCG3/w6glZMcop1Olazvpprc9cuyoNvHENcSdu7neCeRKupyz4IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780081419; c=relaxed/simple;
	bh=Pv50zs0nxpws1ftfV8aEvj4opPcka5fP0ZqnFgTXb14=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=iv1Gp2YsVQZDOe9uroB/KNzmMXKD0Gvd6hgmQ4khKCbvmlzd6JP2hdwXarQWvcwigyNJWti8Zh1oOxyqDULqCyx9aTeDCjUnqHBLnXgjMBZNkaXEBb9SXYVgbgSje5qh1dYb86AhC+sDvDNxGc0GrWz86KWEBGIihoyYBGLYOf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=unpredictable.fr; spf=pass smtp.mailfrom=unpredictable.fr; dkim=pass (2048-bit key) header.d=unpredictable.fr header.i=@unpredictable.fr header.b=IVVgtVKN; arc=none smtp.client-ip=57.103.76.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=unpredictable.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unpredictable.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unpredictable.fr header.i=@unpredictable.fr header.b="IVVgtVKN"
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-2 (Postfix) with ESMTPS id 54CDB18003BF;
	Fri, 29 May 2026 19:03:33 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCh5cAEsdVwRUH1MSVR0dC0VLQBMESwNNXw5eHwQXRhlVBEceXVZAGRkCURxWDVdDVARfUEkMQVBsWgBHF0gdXRlZb1BdHA4YWRtAFV0RUBlWCV4VFx5BTVoCVk0FQAtVDi4HRQ5VBF90Kh9EfT13QHVbBDUUTHdVBVoBRXo+Cl8EK0ceSQpWCV4IRhFbFFZDURkMUE0BQwgKCEcDTRdeMlMEXxFQFg==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr; s=sig1; t=1780081414; x=1782673414; bh=L5MbozJ5ZtclVRHz2/UqMohOJuTYcCfjXEZ5p11/12M=; h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme; b=IVVgtVKNoeujD2aToxqnTEDEGofjD0PbXjBayJ13XZDLzrJC0Qth6X2sjlnjIRBmfFSRaf+kSR4VCFIzlB+A5gSM1SA0zOwQ4NQMUAVy9Dv+UvSl7SvX2ldlA9b2LVrE5uwsYwxP3BwdURT3xmKdoQOKpQWzCyzlmGt2JwfT72qH+p90UGyjEoCiXzQ+8LVoD80jFIBKAPlXS8QAyWP36RAU/emWY7+FiXn4MxT3HLWlA+xXoizHVkFJncqE33SnDJfUfC0iG6U8RLRxPIHRx2lOSawib4hRNQOo/0VN3dFc4CfS7vCNd22VVxkx3PFUUSvof0JBdTd0J1hZSgpmmw==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.42.251.67])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-2 (Postfix) with ESMTPSA id 5FAFB18011CD;
	Fri, 29 May 2026 19:03:29 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH 07/17] accel/whpx: Convert AccelCPUClass ->
 AccelOpsClass::cpu_instance_init
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260529142434.87880-8-philmd@linaro.org>
Date: Fri, 29 May 2026 21:03:17 +0200
Cc: qemu-devel@nongnu.org,
 Reinoud Zandijk <reinoud@netbsd.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Alexander Graf <agraf@csgraf.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Anton Johansson <anjo@rev.ng>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Song Gao <gaosong@loongson.cn>,
 qemu-riscv@nongnu.org,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Alistair Francis <alistair.francis@wdc.com>,
 qemu-ppc@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 kvm@vger.kernel.org,
 Claudio Fontana <cfontana@suse.de>,
 Chinmay Rath <rathc@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8889E557-72CA-4DED-B06E-4D82135CF923@unpredictable.fr>
References: <20260529142434.87880-1-philmd@linaro.org>
 <20260529142434.87880-8-philmd@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3864.500.181)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE5MCBTYWx0ZWRfX4o4D5iz7EZwB
 PafAprm4LAshjRT8vyziar5UHXlrRXeaCPpL8YtaSFbSe+khRmYckQMr8HJM+wFDb0UzxhbJ2f0
 vbVX5PY+D6pzFCt54DkKrz//hqR9i3C/zrVD0gyG6wILpCyhq7kQWANXj0l95ZDk+QdRE8Jr2F4
 7gRhv3KD/jPqNaKEF40tXEpDAKNVM+8ik7645wl4FXn3rWsjFNrQVLw5YSbySX4pf3TiMg4a8k2
 9xTnU0wK1CGgjZ1xEhBW2uUc2jbecGk+/pUf0pA/WaC6McGzCdUnVudt1b0s9461fPBMhSnIxve
 V8njC4Z6OtNr44Eo8CaHNJkAcv7dF4i5fMgO4+1fyf+habX8GesupW6T7OIaf8=
X-Proofpoint-GUID: vYP-en4IsCvIH_H4la6OLn5fC5b_mBMB
X-Authority-Info-Out: v=2.4 cv=Jtb8bc4C c=1 sm=1 tr=0 ts=6a19e306
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=S16TypstT75ussWUPpsA:9
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: vYP-en4IsCvIH_H4la6OLn5fC5b_mBMB



> On 29. May 2026, at 16:24, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>=20
> Register the new AccelOpsClass::cpu_instance_init hook.
>=20
> ACCEL_CPU_NAME("whpx") TypeInfo is now empty, remove it.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> accel/whpx/whpx-accel-ops.c |  2 ++
> accel/whpx/whpx-common.c    | 17 -----------------
> target/arm/whpx/whpx-all.c  |  1 -
> target/i386/whpx/whpx-all.c |  1 -
> 4 files changed, 2 insertions(+), 19 deletions(-)
>=20
> diff --git a/accel/whpx/whpx-accel-ops.c b/accel/whpx/whpx-accel-ops.c
> index b8f41544cbe..099e8ef6da3 100644
> --- a/accel/whpx/whpx-accel-ops.c
> +++ b/accel/whpx/whpx-accel-ops.c
> @@ -98,6 +98,8 @@ static void whpx_accel_ops_class_init(ObjectClass =
*oc, const void *data)
>     ops->handle_interrupt =3D generic_handle_interrupt;
>     ops->supports_guest_debug =3D whpx_supports_guest_debug;
>=20
> +    ops->cpu_instance_init =3D whpx_cpu_instance_init;
> +
Hi,

No whpx_cpu_instance_init implementation present in the commit
as far as I can tell.

Did you miss it? Other than that things look fine and a stub =
implementation=20
should be okay.

>     ops->synchronize_post_reset =3D whpx_cpu_synchronize_post_reset;
>     ops->synchronize_post_init =3D whpx_cpu_synchronize_post_init;
>     ops->synchronize_state =3D whpx_cpu_synchronize_state;
> diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
> index 247e12db812..25c5d84fd30 100644
> --- a/accel/whpx/whpx-common.c
> +++ b/accel/whpx/whpx-common.c
> @@ -24,7 +24,6 @@
> #include "qapi/qapi-types-common.h"
> #include "qapi/qapi-visit-common.h"
> #include "migration/blocker.h"
> -#include "accel/accel-cpu-target.h"
> #include <winerror.h>
>=20
> #include "system/whpx-internal.h"
> @@ -505,21 +504,6 @@ static void whpx_set_hyperv(Object *obj, Visitor =
*v,
>     }
> }
>=20
> -static void whpx_cpu_accel_class_init(ObjectClass *oc, const void =
*data)
> -{
> -    AccelCPUClass *acc =3D ACCEL_CPU_CLASS(oc);
> -
> -    acc->cpu_instance_init =3D whpx_cpu_instance_init;
> -}
> -
> -static const TypeInfo whpx_cpu_accel_type =3D {
> -    .name =3D ACCEL_CPU_NAME("whpx"),
> -
> -    .parent =3D TYPE_ACCEL_CPU,
> -    .class_init =3D whpx_cpu_accel_class_init,
> -    .abstract =3D true,
> -};
> -
> static void whpx_accel_class_init(ObjectClass *oc, const void *data)
> {
>     AccelClass *ac =3D ACCEL_CLASS(oc);
> @@ -569,7 +553,6 @@ static const TypeInfo whpx_accel_type =3D {
> static void whpx_type_init(void)
> {
>     type_register_static(&whpx_accel_type);
> -    type_register_static(&whpx_cpu_accel_type);
> }
>=20
> bool init_whp_dispatch(void)
> diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
> index 3079c6293c8..16040f102a3 100644
> --- a/target/arm/whpx/whpx-all.c
> +++ b/target/arm/whpx/whpx-all.c
> @@ -23,7 +23,6 @@
> #include "qapi/qapi-types-common.h"
> #include "qapi/qapi-visit-common.h"
> #include "migration/blocker.h"
> -#include "accel/accel-cpu-target.h"
> #include <winerror.h>
>=20
> #include "syndrome.h"
> diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
> index e626acef2f0..1b68f13a7dd 100644
> --- a/target/i386/whpx/whpx-all.c
> +++ b/target/i386/whpx/whpx-all.c
> @@ -33,7 +33,6 @@
> #include "qapi/qapi-visit-common.h"
> #include "migration/blocker.h"
> #include "host-cpu.h"
> -#include "accel/accel-cpu-target.h"
> #include <winerror.h>
>=20
> #include "system/whpx-internal.h"
> --=20
> 2.53.0
>=20
>=20

