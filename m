Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=57.103.66.31
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795269768;
	b=HV2Ay+k68F9Kqw5m0QBBJsfbA0ZJ5zReln9CBVbTRHACh2iQbZKHtdj4ajeYYtk7tfEv
	 o1RGCjLpUtTuubhN92MxwezmPchAjOi6sIVkRQgh8CCGsfPBxJ3MyJsGgDsknr07CA6Cq
	 ysinR5asmQkjHI0FQwhAeufgiyjiKdAfKMoVM2PjwTiZ1hPykbj1Ej3900jMIu0GWdW0w
	 Rtx+nCwvQNXhMnjdmilBlV33K4DZSB7H8UYI7XZcH618oNd+0F6hDXazIyluFJ2zWXGQ/
	 e72ntLzWnqMeOYlU3z2uv6KE2ct9E0umkxnQgaESwy1YkTUE5MmG4M3730H07cab1Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795269768;
	h=DMARC-Filter:Received:X-ICL-RepId:Dkim-Signature:
	 mail-alias-created-date:Received:Content-Type:Mime-Version:Subject:
	 From:In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:
	 References:To:X-Mailer:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Info-Out:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-JNJ;
	bh=meRts+4c2DtvafLoPOB2t1PMRGHTWUuFfoHRJUX3y9M=;
	b=Xqjowz7ZLzWouKN7dDViAuDny+UW61I/llzQOIgWd4NH2ARdV/ShyhG3peSjjsn/noOF
	 cS55InoSUq682rhfgJuxycOikvrAVXGMGa3gLMbf9aPud/AYZcUNn/yEApK19Kg76cctP
	 1TlfWx+YHHXryWk068RAVkL5LCOVEKWm1hgI4991qB07utkG0t5f+dLnpWJBQUoNJEgw2
	 3OFRciyBdqCsHYuJZS5zP3VKHWsTuje/DoZUIcgtV1qIJ29zdu8MXjvc4n7sZ/ysgc/Qk
	 /o881YskQdQ9BqOyVqE6ge8wEj2GEnUHob/7Zc4r+GHxB9zWdLuiU3XT8AYWsHTPrCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=unpredictable.fr;
	spf=pass smtp.mailfrom=unpredictable.fr;
	dkim=pass header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=iWG3lUtv;
	arc=none smtp.remote-ip=57.103.66.31
Received: from outbound.pv.icloud.com (pv-2003k-snip4-8.eps.apple.com [57.103.66.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97250606A320
	for <kvm@vger.kernel.org>; Sat, 21 Nov 2026 14:02:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97250606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=unpredictable.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unpredictable.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=iWG3lUtv
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-1a-100-percent-3 (Postfix) with ESMTPS id 230061800362;
	Sat, 21 Nov 2026 14:02:44 +0000 (UTC)
X-ICL-RepId: 01a1fe6a-a798-7255-af01-793527205911
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr; s=sig1; t=1795269767; x=1826805767; bh=meRts+4c2DtvafLoPOB2t1PMRGHTWUuFfoHRJUX3y9M=; h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme; b=iWG3lUtvaSxTK9DmLJUTbIC8POKFjjQjIaFXOTab+R8fCZUIinSuK9Xly7tyZhUwrf+50J1jOhopAdvvdCBrrumb1c0GOMbGOImEB0HmXFTtCJbDNs6UIRk7lrsbNvBnycyKUxArUXtMcs2j+pErezxE0BkoA+70JC2xK8gEVjP8R17Eyn0coSfljgVUIBvCW7aSOZhHkwek1fUjhl4haY+QyDKlyVRDLCGrqhtWWr01QxfDi5RAp85G0Et/HPKq8KtX+1uKH5SHRA0TdTBD0z8FwklFg5jrb9fnQtXUJwtZsWj7cmQQq0VMjv6OT159IU3lm+iJlx/aPIt/2wyH4Q==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.156.192.29])
	by p00-icloudmta-asmtp-us-west-1a-100-percent-3 (Postfix) with ESMTPSA id D11B718007F6;
	Sat, 21 Nov 2026 14:02:42 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH 1/1] hw/arm/virt: add vhe option for nested virtualization
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20261121095636.289814-2-haseebashraf091@gmail.com>
Date: Sat, 21 Nov 2026 15:02:32 +0100
Cc: Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org,
 Haseeb Ashraf <haseeb.ashraf@siemens.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Volodymyr Babchuk <volodymyr.babchuk@epam.com>,
 qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <5B0A91A9-656F-479F-963B-43AE8D23446B@unpredictable.fr>
References: <20261121095636.289814-1-haseebashraf091@gmail.com>
 <20261121095636.289814-2-haseebashraf091@gmail.com>
To: Haseeb Ashraf <haseebashraf091@gmail.com>
X-Mailer: Apple Mail (2.3901.200.71.1.16)
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIxMDA1NSBTYWx0ZWRfXwO884UxVRlZv
 fj7BDsT0QHpuEDAa5C+Ho3PiZ0aonqmepyLb9c5uDQEk4KDmvYQyDjqq+iQ2f5UE4VpB2AkmIJM
 7Z+HvP4zmGSv9m9QW3wQns+9DTLiIUM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIxMDA1NSBTYWx0ZWRfX/PLwryFOnKDP
 M3cflE//VRVoTg71EupRFe4YRm/itDJxCz9YDsRHmj4HNQFLBsRVFLqpbMtstelPcE/lwyv9Ald
 6mUG5+mpc29/nYFO7WqPkJFRP3sbJ7apbzn32E/OmJ8PKUHP6c9dGIHJezEwXa8+RuPNQQjCN3s
 OkAjyq74YK8I9f1O8QX7w73mZeRanpE5Xe7vr6sruBUpjML+hvf+q7H4q4+8c4dqNIYS/wlZu+X
 DByO9dIcyq/8J4AD/KwW+aWrcmlTVILDBeNfo8Slq2mcwl0W6xF+t+lWjURRsjlbg1OEbqOjbly
 +Y4yRKG+BM7wfOilUL7CgRJ7Q2yu6yz3H08GdT1pwPUk56tlUruoWjLqTQvcho=
X-Authority-Info-Out: v=2.4 cv=Sfli5fRu c=1 sm=1 tr=0 ts=6b01a486
 cx=c_apl:c_pps:t_out a=aW9mcIavGNWWFvFFKOxBSA==:117
 a=aW9mcIavGNWWFvFFKOxBSA==:17 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=wbbCu9YnSpm8ZdSLOl1R:22 a=AAKO-It69yxVJjVG_j8g:22
 a=pGLkceISAAAA:8 a=a_U1oVfrAAAA:8 a=DBfv99YmAAAA:8 a=WP5zsaevAAAA:8
 a=tzMVfLCtRBOIxXHF2CQA:9 a=CjuIK1q_8ugA:10 a=t8Kx07QrZZTALmIZmm-o:22
X-Proofpoint-ORIG-GUID: rxJVTbl4TJ-tfjGm6w1PfWqijERoq3yi
X-Proofpoint-GUID: rxJVTbl4TJ-tfjGm6w1PfWqijERoq3yi
X-JNJ: AAAAAAABEuEKYdTomu3v3MtBLSYI4FzCLYdn3X7zWmRYOwlBOvIRR1mbo6PTm0MgtsW3iD
 NEhdStWJUbm9rgIE9yqkEQh7tibDh52G/HwfxJPLqwSa2HzedBVnKBMSmL/1qLfCi0wkV3
 bwWclT+Hup9WVXaRAw481lJJVL9v+DObx6Vvj+50Z15YBLPUhulz+gw2JGaDo93FBdL5Nz
 LQbNqXTxKKWkJnhQE5bWtCVDCv/USRcl82gX4A+HlGBtfZMW6or0eRkzTfUDgvul+QICD0
 7RnmKLBjH759CG4oxFn93jtLzy5FbAPsxrr8PWMdl5En8ouvEQ0QXAXH5+E4x82+0/rSmg
 Z2DfpUmbcX55HO8ZrgqsYgxA4A9O8/6F53S0aORZkYmiNsOhEAocGeC59KxdZIZjvFHgk2
 g9/NS4IvhTLjr/m4qGP4nTpY6h9nlnRRqzvuBOitwwInjiykQ38CWgpZSHCzGqZKgicBDV
 fh5lfFriLMXcteacuaNzCpp1KQ6m0dKxbMja8SIq4Xce02M/WWtaE3T6FCoDvLIGNrL+26
 ZoNJ5mjrksSHnnvSs9LNYjJibnJvOEQvQV0UyvtoXlmIzLKs9ajDsc8efCRsMTG9T0yhFh
 ixd6q0g3Fg0YlV1zsvd5eR/spL2R3pjboEQc5I4l5EkB+JvfnmlDFx0vJWmPIM05kO+HXK
 dsFtRbfi/N18kZI6uJTxerckB7HelMsYUyAyrKFbhZi9DvxyKGVtqg1kr0eTJIKOYsR3k1
 1q9NEUtt2UZP8kR9OdABT/WNJROIu7cV+uogUesPKeV7rGOq38CBdFSICZwRfbPNlMu+rA
 D8opsUkyVfPVkVnXZxYkRxk4LBilu+csHtgEzvLRBbwWnQk52yVfFPdu



> On 21. Nov 2026, at 10:56, Haseeb Ashraf <haseebashraf091@gmail.com> =
wrote:
>=20
> From: Haseeb Ashraf <haseeb.ashraf@siemens.com>
>=20
> Add a vhe machine property for the virt board. When virtualization=3Don,=

> VHE remains enabled by default, but vhe=3Doff allows nVHE/type-1 guest
> hypervisors to run without VHE.
>=20
> Propagate the setting to the ARM CPU, limit TCG to nVHE mode, and =
request
> the KVM_ARM_VCPU_HAS_EL2_E2H0 vCPU initialization flag when VHE is
> disabled. Reject vhe=3Doff when the selected accelerator cannot =
provide
> the requested behavior. The option has no effect unless
> virtualization=3Don is also set.
>=20
> Document the option, and make the nested virtualization functional =
test
> pass a vhe setting matching the kernel mode.
>=20
> Tested nested virtualization with KVM on arm64 hosts using L0 kernel
> versions 6.18.29 and 7.2.11. A Linux 6.12.67 guest initialized KVM in
> nVHE mode with vhe=3Doff and VHE mode with vhe=3Don. QNX Hypervisor =
8.0.5
> detected EL1 host hypervisor support with vhe=3Doff and EL2 host
> hypervisor support with vhe=3Don. Xen booted dom0 to the login prompt =
with
> vhe=3Doff, but did not boot with vhe=3Don.
>=20
> Tested with TCG on an AmpereOne A192-32X host. QNX Hypervisor 8.0.5
> boots with both vhe settings, and Xen boots its dom0 with vhe=3Doff.
>=20
> Suggested-by: Volodymyr Babchuk <volodymyr.babchuk@epam.com>
> Signed-off-by: Haseeb Ashraf <haseeb.ashraf@siemens.com>

Hi,

> ---
> docs/system/arm/virt.rst             | 10 ++++++++
> hw/arm/virt.c                        | 37 ++++++++++++++++++++++++++++
> include/hw/arm/virt.h                |  1 +
> target/arm/cpu.c                     | 15 +++++++++++
> target/arm/cpu.h                     |  2 ++
> target/arm/kvm-stub.c                |  5 ++++
> target/arm/kvm.c                     |  8 ++++++
> target/arm/kvm_arm.h                 | 12 +++++++++
> tests/functional/aarch64/test_kvm.py | 10 +++++---
> 9 files changed, 97 insertions(+), 3 deletions(-)
>=20
> diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
> index 5f6dd17978..31f0878788 100644
> --- a/docs/system/arm/virt.rst
> +++ b/docs/system/arm/virt.rst
> @@ -116,6 +116,16 @@ virtualization
>   Set ``on``/``off`` to enable/disable emulating a guest CPU which =
implements the
>   Arm Virtualization Extensions. The default is ``off``.
>=20
> +vhe
> +  Set ``on``/``off`` to allow/disallow a guest hypervisor to use the =
Arm
> +  Virtualization Host Extensions (``FEAT_VHE``) when =
``virtualization`` is
> +  ``on``. The default is ``on``, which places no restriction on the =
selected
> +  CPU model (it does not add VHE to a CPU model which lacks it). =
``off``
> +  exposes EL2 in nVHE mode for a type-1 guest hypervisor: with TCG =
this hides
> +  ``FEAT_VHE``, with KVM it requires host ``E2H0`` support, and it is =
not
> +  supported with HVF. This option has no effect when =
``virtualization`` is
> +  ``off``.
If going this machine property route:

This should be a tristate: on/off/auto

With auto being the default: both nVHE and VHE when the CPU supports =
that, and
neither with no EL2 exposed to the guest.

> +
> mte
>   Set ``on``/``off`` to enable/disable emulating a guest CPU which =
implements the
>   Arm Memory Tagging Extensions. The default is ``off``.
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 0b11f7e328..1a987faa19 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -3025,6 +3025,12 @@ static void machvirt_init(MachineState =
*machine)
>         exit(1);
>     }
>=20
> +    if (vms->virt && !vms->vhe && hvf_enabled()) {
> +        error_report("mach-virt: %s does not support disabling VHE",
> +                     current_accel_name());
> +        exit(1);
> +    }

Does not support enabling VHE. The (experimental) patch to enable VHE
with HVF is elsewhere on this mailing list.

Currently, Apple only ships nVHE with Hypervisor.framework, with VHE
being a pre-release feature.

> +
>     if (vms->mte && hvf_enabled()) {
>         error_report("mach-virt: %s does not support providing "
>                      "MTE to the guest CPU",
> @@ -3069,6 +3075,10 @@ static void machvirt_init(MachineState =
*machine)
>             object_property_set_bool(cpuobj, "has_el2", false, NULL);
>         }
>=20
> +        if (vms->virt && object_property_find(cpuobj, "has_vhe")) {
> +            object_property_set_bool(cpuobj, "has_vhe", vms->vhe, =
NULL);
> +        }
> +
>         if (vmc->no_kvm_steal_time &&
>             object_property_find(cpuobj, "kvm-steal-time")) {
>             object_property_set_bool(cpuobj, "kvm-steal-time", false, =
NULL);
> @@ -3308,6 +3318,20 @@ static void virt_set_virt(Object *obj, bool =
value, Error **errp)
>     hvf_nested_virt_enable(value);
> }
>=20
> +static bool virt_get_vhe(Object *obj, Error **errp)
> +{
> +    VirtMachineState *vms =3D VIRT_MACHINE(obj);
> +
> +    return vms->vhe;
> +}
> +
> +static void virt_set_vhe(Object *obj, bool value, Error **errp)
> +{
> +    VirtMachineState *vms =3D VIRT_MACHINE(obj);
> +
> +    vms->vhe =3D value;
> +}
> +
> static bool virt_get_highmem(Object *obj, Error **errp)
> {
>     VirtMachineState *vms =3D VIRT_MACHINE(obj);
> @@ -4235,6 +4259,13 @@ static void virt_machine_class_init(ObjectClass =
*oc, const void *data)
>                                           "guest CPU which implements =
the ARM "
>                                           "Virtualization =
Extensions");
>=20
> +    object_class_property_add_bool(oc, "vhe", virt_get_vhe,
> +                                   virt_set_vhe);
> +    object_class_property_set_description(oc, "vhe",
> +                                          "Set on/off to =
enable/disable the ARM "
> +                                          "Virtualization Host =
Extensions (applicable "
> +                                          "only when =
virtualization=3Don)");

As said above, should be a tristate at least.

> +
>     object_class_property_add_bool(oc, "highmem", virt_get_highmem,
>                                    virt_set_highmem);
>     object_class_property_set_description(oc, "highmem",
> @@ -4375,6 +4406,12 @@ static void virt_instance_init(Object *obj)
>     /* EL2 is also disabled by default, for similar reasons */
>     vms->virt =3D false;
>=20
> +    /*
> +     * VHE is unrestricted by default when virtualization=3Don is =
set.
> +     * With vhe=3Doff, EL2 is limited to nVHE mode.
> +     */
> +    vms->vhe =3D true;
> +
>     /* High memory is enabled by default */
>     vms->highmem =3D true;
>     vms->highmem_compact =3D !vmc->no_highmem_compact;
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index 22e66d1a11..bd0065efb1 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -174,6 +174,7 @@ struct VirtMachineState {
>     bool highmem_redists;
>     bool tcg_its;
>     bool virt;
> +    bool vhe;
>     bool ras;
>     bool mte;
>     bool dtb_randomness;
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index dde03ffdd6..4d272b5388 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1326,6 +1326,9 @@ static const Property =
arm_cpu_reset_hivecs_property =3D
> static const Property arm_cpu_has_el2_property =3D
>             DEFINE_PROP_BOOL("has_el2", ARMCPU, has_el2, true);
>=20
> +static const Property arm_cpu_has_vhe_property =3D
> +            DEFINE_PROP_BOOL("has_vhe", ARMCPU, has_vhe, true);
> +
> static const Property arm_cpu_has_el3_property =3D
>             DEFINE_PROP_BOOL("has_el3", ARMCPU, has_el3, true);
>=20
> @@ -1622,6 +1625,7 @@ static void arm_cpu_post_init(Object *obj)
>=20
>     if (arm_feature(&cpu->env, ARM_FEATURE_EL2)) {
>         qdev_property_add_static(DEVICE(obj), =
&arm_cpu_has_el2_property);
> +        qdev_property_add_static(DEVICE(obj), =
&arm_cpu_has_vhe_property);
>     }
> #endif
>=20
> @@ -1872,6 +1876,13 @@ static void arm_cpu_realizefn(DeviceState *dev, =
Error **errp)
>         return;
>     }
>=20
> +    if (cpu->has_el2 && !cpu->has_vhe && kvm_enabled() &&
> +        !kvm_arm_el2_e2h0_supported()) {
> +        error_setg(errp, "KVM does not support disabling VHE (E2H0 "
> +                   "unavailable)");
> +        return;
> +    }
> +
> #ifndef CONFIG_USER_ONLY
>     /* The NVIC and M-profile CPU are two halves of a single piece of
>      * hardware; trying to use one without the other is a command line
> @@ -2246,6 +2257,10 @@ static void arm_cpu_realizefn(DeviceState *dev, =
Error **errp)
>         unset_feature(env, ARM_FEATURE_EL2);
>     }
>=20
> +    if (cpu->has_el2 && !cpu->has_vhe && tcg_enabled()) {
> +        FIELD_DP64_IDREG(isar, ID_AA64MMFR1, VH, 0);
> +    }
> +
>     if (!cpu->has_pmu) {
>         unset_feature(env, ARM_FEATURE_PMU);
>     }
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index b2f393f501..2f94fdae7b 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1022,6 +1022,8 @@ struct ArchCPU {
>     bool has_el2;
>     /* CPU has security extension */
>     bool has_el3;
> +    /* CPU has virtualization host extensions */
> +    bool has_vhe;
>     /* CPU has PMU (Performance Monitor Unit) */
>     bool has_pmu;
>     /* CPU has VFP */
> diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
> index 88cbe8d85c..6eb9e1366a 100644
> --- a/target/arm/kvm-stub.c
> +++ b/target/arm/kvm-stub.c
> @@ -42,6 +42,11 @@ bool kvm_arm_el2_supported(void)
>     return false;
> }
>=20
> +bool kvm_arm_el2_e2h0_supported(void)
> +{
> +    return false;
> +}
> +
> /*
>  * These functions should never actually be called without KVM =
support.
>  */
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index df86ad387c..6b95ed1da8 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -2003,6 +2003,11 @@ bool kvm_arm_el2_supported(void)
>     return kvm_check_extension(kvm_state, KVM_CAP_ARM_EL2);
> }
>=20
> +bool kvm_arm_el2_e2h0_supported(void)
> +{
> +    return kvm_check_extension(kvm_state, KVM_CAP_ARM_EL2_E2H0);
> +}
> +
> bool kvm_arm_mte_supported(void)
> {
>     return kvm_check_extension(kvm_state, KVM_CAP_ARM_MTE);
> @@ -2060,6 +2065,9 @@ static void =
kvm_arm_vcpu_prepare_init_features(ARMCPU *cpu)
>     }
>     if (cpu->has_el2 && kvm_arm_el2_supported()) {
>         cpu->kvm_init_features[0] |=3D 1 << KVM_ARM_VCPU_HAS_EL2;
> +        if (!cpu->has_vhe) {
> +            cpu->kvm_init_features[0] |=3D 1 << =
KVM_ARM_VCPU_HAS_EL2_E2H0;
> +        }
>     }
> }
>=20
> diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
> index 9c7e7f654a..24828e9c07 100644
> --- a/target/arm/kvm_arm.h
> +++ b/target/arm/kvm_arm.h
> @@ -182,6 +182,13 @@ bool kvm_arm_mte_supported(void);
>  * Returns true if KVM can enable EL2 and false otherwise.
>  */
> bool kvm_arm_el2_supported(void);
> +
> +/**
> + * kvm_arm_el2_e2h0_supported:
> + *
> + * Returns true if KVM supports limiting EL2 to E2H=3D0, and false =
otherwise.
> + */
> +bool kvm_arm_el2_e2h0_supported(void);
> #else
>=20
> static inline bool kvm_arm_aarch32_supported(void)
> @@ -198,6 +205,11 @@ static inline bool kvm_arm_el2_supported(void)
> {
>     return false;
> }
> +
> +static inline bool kvm_arm_el2_e2h0_supported(void)
> +{
> +    return false;
> +}
> #endif
>=20
> /**
> diff --git a/tests/functional/aarch64/test_kvm.py =
b/tests/functional/aarch64/test_kvm.py
> index c977e8c6d2..502060a109 100755
> --- a/tests/functional/aarch64/test_kvm.py
> +++ b/tests/functional/aarch64/test_kvm.py
> @@ -40,7 +40,9 @@ def _launch_guest(self, kvm_mode=3D"nvhe"):
>                                f"console=3DttyAMA0 =
kvm-arm.mode=3D{kvm_mode}")
>=20
>         self.vm.add_args("-cpu", "max")
> -        self.vm.add_args("-machine", =
"virt,gic-version=3D3,virtualization=3Don",
> +        vhe =3D "on" if kvm_mode =3D=3D "vhe" else "off"
> +        self.vm.add_args("-machine",
> +                         =
f"virt,gic-version=3D3,virtualization=3Don,vhe=3D{vhe}",
>                          '-kernel', kernel_path,
>                          '-append', kernel_command_line)
>         self.vm.add_args("-smp", "2", "-m", "320")
> @@ -48,8 +50,10 @@ def _launch_guest(self, kvm_mode=3D"nvhe"):
>         try:
>             self.vm.launch()
>         except VMLaunchFailure as excp:
> -            if "does not support providing Virtualization" in =
excp.output:
> -                self.skipTest("accelerator has no virtualization =
support")
> +            if ("does not support providing Virtualization" in =
excp.output or
> +                    "does not support disabling VHE" in excp.output):
> +                self.skipTest("accelerator lacks the required =
virtualization "
> +                              "support")
>             else:
>                 self.log.info("unhandled launch failure: %s", =
excp.output)
>                 raise excp
> --=20
> 2.34.1
>=20
>=20

